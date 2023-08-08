/* Author: Sachin Chavan 
 * Date: April 26, 2019
 */


import { LightningElement, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
import CropperResource from '@salesforce/resourceUrl/Cropper';
import saveImage from '@salesforce/apex/ImageCropperController.saveImage';

export default class ImageCropper extends LightningElement {

    @api recordId;
    @api height = 300;
    @api width = 300;
    @track cropper;
    @track isProcessing = false;

    connectedCallback() {
        Promise.all([
            loadStyle(this, CropperResource + '/cropper.css'),
            loadScript(this, CropperResource + '/cropper.js')
        ]);
    }

    handleFilesChange(event) {
        const template = this.template;
        const files = event.detail.files;
        const reader = new FileReader();
        reader.onload = (fileEvent) => {
            const imageEl = template.querySelector('.canvas-image');
            imageEl.src = fileEvent.target.result;

            this.cropper = new Cropper(imageEl, {
                autoCrop: false,
                viewMode: 1,
                aspectRatio: 4 / 3,
                dragMode: 'none'
            });
        };

        reader.readAsDataURL(files[0]);
    }

    onZoomInClick() {
        this.cropper.zoom(0.1);
    }

    onZoomOutClick() {
        this.cropper.zoom(-0.1);
    }

    onScaleXClick() {
        this.cropper.scaleX(-1);
    }

    onScaleYClick() {
        this.cropper.scaleY(-1);
    }

    onLeftRotateClick() {
        this.cropper.rotate(-90);
    }

    onRightRotateClick() {
        this.cropper.rotate(90);
    }

    onCropClick() {
        this.cropper.setDragMode('crop');
    }

    onSaveClick() {
        const imageEl = this.template.querySelector('.canvas-preview');
        //imageEl.src = this.cropper.getCroppedCanvas().toDataURL('image/png');
        imageEl.src = this.cropper.getCroppedCanvas({
            width: this.width,
            height: this.height,
            minWidth: 256,
            minHeight: 256,
            maxWidth: 4096,
            maxHeight: 4096,
            fillColor: '#fff',
            imageSmoothingEnabled: false,
            imageSmoothingQuality: 'high',
        }).toDataURL('image/png');


        if (imageEl.src) {
            this.template.querySelector('.modal-container').style.display = 'block';
        } else {
            const event = new ShowToastEvent({
                title: 'Message',
                type: 'error',
                message: 'Please select image.'
            });
            this.dispatchEvent(event);
        }
    }

    onResetClick() {
        this.cropper.setDragMode('none');
        this.cropper.reset();
    }

    onDisableClick() {
        this.cropper.disable();
    }

    onEnableClick() {
        this.cropper.enable();
    }

    onCancelChanges() {
        const imageEl = this.template.querySelector('.canvas-preview');
        imageEl.src = '';
        this.template.querySelector('.modal-container').style.display = 'none';
    }

    onSaveChanges() {
        if (!this.isProcessing) {
            const imageEl = this.template.querySelector('.canvas-preview');
            let imageData = imageEl.src;
            const base64 = 'base64,';
            const dataStart = imageData.indexOf(base64) + base64.length;
            imageData = imageData.substring(dataStart);

            this.isProcessing = true;
            saveImage({ recordId: this.recordId, fileName: this.fileName, imageData: imageData })
                .then(response => {
                    this.isProcessing = false;
                    imageEl.src = '';
                    this.template.querySelector('.modal-container').style.display = 'none';

                    const event = new ShowToastEvent({
                        title: 'Message',
                        type: 'success',
                        message: response
                    });
                    this.dispatchEvent(event);
                })
                .catch(error => {
                    this.isProcessing = false;
                    const event = new ShowToastEvent({
                        title: 'Message',
                        type: 'error',
                        message: 'An error occurred while processing your request. Please contact your administrator.'
                    });
                    this.dispatchEvent(event);
                });
        }
    }

}
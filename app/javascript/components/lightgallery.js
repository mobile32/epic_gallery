import 'lightgallery/dist/css/lightgallery.css'
import 'lightgallery/dist/js/lightgallery'

// lightgallery plugins
import 'lightgallery/modules/lg-fullscreen'
import 'lightgallery/modules/lg-thumbnail'
import 'lightgallery/modules/lg-zoom'

export default function initLightGallery() {
    $("#lightgallery").lightGallery();
}
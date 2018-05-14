import '../styles/application.scss';

import 'bootstrap/dist/js/bootstrap';
import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';

import initLightGallery from '../components/lightgallery'

import 'select2/dist/js/select2.full'

Rails.start();
Turbolinks.start();

$(document).on('turbolinks:load', function () {
    initLightGallery();


    $('.autocomplete-search-tags').select2();

    $('.autocomplete-search-tags').on('select2:opening select2:closing', function( event ) {
        var $searchfield = $(this).parent().find('.select2-search__field');
        $searchfield.prop('disabled', true);
    });


    $(".autocomplete-add-tags").select2({
        tags: true
    });
});
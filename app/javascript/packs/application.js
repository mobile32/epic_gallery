import '../styles/application.scss';

import 'bootstrap/dist/js/bootstrap';
import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';

import initLightGallery from '../components/lightgallery'

Rails.start();
Turbolinks.start();

$(document).on('turbolinks:load', function () {
  initLightGallery();
});
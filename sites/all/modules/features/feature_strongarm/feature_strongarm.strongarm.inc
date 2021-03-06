<?php
/**
 * @file
 * feature_strongarm.strongarm.inc
 */

/**
 * Implements hook_strongarm().
 */
function feature_strongarm_strongarm() {
  $export = array();

  $strongarm = new stdClass();
  $strongarm->disabled = FALSE; /* Edit this to true to make a default strongarm disabled initially */
  $strongarm->api_version = 1;
  $strongarm->name = 'jquerymenu_animate';
  $strongarm->value = 1;
  $export['jquerymenu_animate'] = $strongarm;

  $strongarm = new stdClass();
  $strongarm->disabled = FALSE; /* Edit this to true to make a default strongarm disabled initially */
  $strongarm->api_version = 1;
  $strongarm->name = 'jquerymenu_edit_link';
  $strongarm->value = 0;
  $export['jquerymenu_edit_link'] = $strongarm;

  $strongarm = new stdClass();
  $strongarm->disabled = FALSE; /* Edit this to true to make a default strongarm disabled initially */
  $strongarm->api_version = 1;
  $strongarm->name = 'jquerymenu_hover';
  $strongarm->value = 0;
  $export['jquerymenu_hover'] = $strongarm;

  $strongarm = new stdClass();
  $strongarm->disabled = FALSE; /* Edit this to true to make a default strongarm disabled initially */
  $strongarm->api_version = 1;
  $strongarm->name = 'jquerymenu_parentlink';
  $strongarm->value = 0;
  $export['jquerymenu_parentlink'] = $strongarm;

  $strongarm = new stdClass();
  $strongarm->disabled = FALSE; /* Edit this to true to make a default strongarm disabled initially */
  $strongarm->api_version = 1;
  $strongarm->name = 'jq_click_to_expand';
  $strongarm->value = 1;
  $export['jq_click_to_expand'] = $strongarm;

  return $export;
}

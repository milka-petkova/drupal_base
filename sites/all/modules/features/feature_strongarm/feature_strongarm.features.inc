<?php
/**
 * @file
 * feature_strongarm.features.inc
 */

/**
 * Implements hook_ctools_plugin_api().
 */
function feature_strongarm_ctools_plugin_api($module = NULL, $api = NULL) {
  if ($module == "strongarm" && $api == "strongarm") {
    return array("version" => "1");
  }
}

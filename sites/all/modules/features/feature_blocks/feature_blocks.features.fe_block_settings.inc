<?php
/**
 * @file
 * feature_blocks.features.fe_block_settings.inc
 */

/**
 * Implements hook_default_fe_block_settings().
 */
function feature_blocks_default_fe_block_settings() {
  $export = array();

  $export['version'] = '2.0';

  $export['jquerymenu-1'] = array(
    'cache' => 'DRUPAL_NO_CACHE',
    'custom' => 0,
    'delta' => 1,
    'module' => 'jquerymenu',
    'node_types' => array(),
    'pages' => '',
    'roles' => array(),
    'themes' => array(
      'bartik' => array(
        'region' => 'content',
        'status' => 1,
        'theme' => 'bartik',
        'weight' => -10,
      ),
      'seven' => array(
        'region' => 'sidebar_first',
        'status' => 1,
        'theme' => 'seven',
        'weight' => 0,
      ),
    ),
    'title' => '',
    'visibility' => 0,
  );

  return $export;
}

<?php

/**
 * @file
 * Enables modules and site configuration for a redweb site installation.
 */

/**
 * Implements hook_isntall_task().
 */
function redweb_install_tasks(&$install_state) {
  return array(
    'redweb_create_initial_content' => array(
      'display_name' => st('Create initial content'),
    ),
  );
}

/**
 * Create and enable initial content that can't be exported to features,
 * but should be available on istallation.
 */
function redweb_create_initial_content() {
  // Create menu links.
  _redweb_create_menu_links();
  // Set the vehicle date format.
  _redweb_add_date_formats();
  // Add html formats.
  _redweb_add_html_formats();
  // Create home page.
  _redweb_create_homepage();
  // Create articles.
  _redweb_create_articles();
  // Create custom articles from command line with drush.
  _redweb_create_drush_articles();
}

/**
 * Helper function that create main menu links.
 */
function _redweb_create_menu_links() {
  $links = array(
    array(
      'link_title' => t('Home'),
      'link_path' => '<front',
      'menu_name' => 'main-menu',
      'weight' => 0,
      'expanded' => 0,
    ),
    array(
      'link_title' => t('Create your own article'),
      'link_path' => 'node/add/article',
      'menu_name' => 'main-menu',
      'weight' => 1,
      'expanded' => 0,
    ),
    array(
      'link_title' => t('Listing of articles'),
      'link_path' => 'articles-listing',
      'menu_name' => 'main-menu',
      'weight' => 2,
      'expanded' => 0,
    ),
  );
  foreach ($links as $link) {
    menu_link_save($link);
  }
}

/**
 * Helper function: Add date formats.
 */
function _redweb_add_date_formats() {

  //Array with date formats.
  $date_format = array(
    'machine_name' => 'standard_uk_format',
    'name' => 'Standard Uk format',
    'format' => ' d/m/y',
    'locked' => 0,
  );
  $result = db_select('date_format_type', 'dft')
      ->fields('dft', array('type'))
      ->condition('type', $date_format['machine_name'])
      ->execute()
      ->fetchCol();

  if (!$result) {
    // Set Standard Uk date.
    db_insert('date_format_type')
        ->fields(array(
          // Machine Name.
          'type' => $date_format['machine_name'],
          // Display Name.
          'title' => $date_format['name'],
          // 1 = can't change through UI, 0 = can change.
          'locked' => $date_format['locked'],
        ))
        ->execute();

    db_insert('date_formats')
        ->fields(array(
          'format' => $date_format['format'],
          'type' => 'custom',
          'locked' => $date_format['locked'],
        ))
        ->execute();

    variable_set('date_format_' . $date_format['machine_name'], $date_format['format']);
  }
}

/**
 * Helper function that add html formats.
 */
function _redweb_add_html_formats() {

  $formats = array(
    0 => array(
      'format' => 'filtered_html',
      'name' => 'Filtered HTML',
      'weight' => 0,
      'filters' => array(
        // URL filter.
        'filter_url' => array(
          'weight' => 0,
          'status' => 1,
        ),
        // HTML filter.
        'filter_html' => array(
          'weight' => 1,
          'status' => 1,
        ),
        // Line break filter.
        'filter_autop' => array(
          'weight' => 2,
          'status' => 1,
        ),
        // HTML corrector filter.
        'filter_htmlcorrector' => array(
          'weight' => 10,
          'status' => 1,
        ),
      ),
    ),
    1 => array(
      'format' => 'full_html',
      'name' => 'Full HTML',
      'weight' => 1,
      'filters' => array(
        // URL filter.
        'filter_url' => array(
          'weight' => 0,
          'status' => 1,
        ),
        // Line break filter.
        'filter_autop' => array(
          'weight' => 1,
          'status' => 1,
        ),
        // HTML corrector filter.
        'filter_htmlcorrector' => array(
          'weight' => 10,
          'status' => 1,
        ),
      ),
    ),
    2 => array(
      'format' => 'mininal_html',
      'name' => 'Minimal HTML',
      'weight' => 2,
      'filters' => array(
        // URL filter.
        'filter_url' => array(
          'weight' => 0,
          'status' => 1,
        ),
        // Line break filter.
        'filter_autop' => array(
          'weight' => 3,
          'status' => 1,
        ),
        // HTML corrector filter.
        'filter_htmlcorrector' => array(
          'weight' => 10,
          'status' => 1,
        ),
      ),
    ),
  );
  foreach ($formats as $format) {
    $new_format = (object) $format;
    filter_format_save($new_format);
  }
}

/**
 * Helper function - create Section page to be used for site home page.
 */
function _redweb_create_homepage() {
  $t = get_t();

  $node = new stdClass();
  $node->title = $t('Home page');
  $node->type = 'page';
  $node->body[LANGUAGE_NONE][] = array('format' => 'filtered_html', 'value' => 'Redweb rocks !');
  // Use one home page for all languages.
  $node->language = LANGUAGE_NONE;
  // Adding certain content-type defaults.
  node_object_prepare($node);
  node_save($node);

  // Setting home page.
  variable_set('site_frontpage', 'node/' . $node->nid);
}

function _redweb_create_articles() {
  $t = get_t();
  $articles = array(
    array(
      'title' => 'This is article 1',
      'body' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas varius mi sapien. Donec pretium eros sed magna dapibus malesuada. Nullam tristique magna sapien, id volutpat nulla condimentum id. Quisque fermentum, sem vel porta efficitur, nibh diam eleifend tortor, pretium consectetur orci nisl ullamcorper mauris. In id velit congue, gravida turpis ac, fermentum ex. Vivamus a purus in lacus pretium fermentum non vel libero. Praesent commodo justo sapien. Donec at suscipit turpis. ',
    ),
    array(
      'title' => 'This is article 2',
      'body' => 'Etiam semper magna ullamcorper cursus tincidunt. Mauris maximus ante urna, non ultrices ipsum sollicitudin vel. Vivamus bibendum efficitur est, ut sodales ligula gravida non. Aenean libero tortor, vehicula nec aliquet at, fermentum id lacus. Etiam hendrerit, ante vitae luctus efficitur, diam lacus sagittis libero, at porttitor lorem massa vitae sem. Nam non risus in ex lacinia pellentesque. Pellentesque sodales elementum neque, sed pulvinar mauris. Cras finibus laoreet euismod. ',
    ),
    array(
      'title' => 'This is article 3',
      'body' => 'Duis vestibulum nulla luctus neque ultricies semper. Pellentesque tincidunt ut purus ac consequat. Nunc porttitor eros et ullamcorper mattis. Donec rhoncus egestas aliquam. Sed viverra tortor urna, eu sodales arcu venenatis sit amet. Nulla malesuada molestie leo, sollicitudin aliquet magna bibendum vel. Aliquam vel suscipit risus. Nullam scelerisque tortor in ipsum finibus, viverra euismod risus ullamcorper. Nunc ornare lacus ullamcorper suscipit fermentum. Nam molestie magna euismod nunc congue, vitae pharetra purus fringilla. ',
    ),
  );

  foreach ($articles as $id => $page) {
    $node = new stdClass();
    $node->title = $t($page['title']);
    $node->type = 'article';
    // Use one home page for all languages.
    $node->language = LANGUAGE_NONE;
    $node->body[LANGUAGE_NONE][] = array('format' => 'filtered_html', 'value' => $page['body']);
    // Adding certain content-type defaults.
    node_object_prepare($node);
    node_save($node);
  }
}

/**
 * Helper function creating articles from drush options.
 */
function _redweb_create_drush_articles() {
  $count = variable_get('redweb_custom_articles', 0);
  if ($count) {
    for ($i = 1; $i < $count; $i++) {
      $node = new stdClass();
      $node->title = t('This article is from drush @i', array('@i' => $i));
      $node->type = 'article';
      // Use one home page for all languages.
      $node->language = LANGUAGE_NONE;
      $node->body[LANGUAGE_NONE][] = array('format' => 'filtered_html', 'value' => 'Body for ' . $i);
      // Adding certain content-type defaults.
      node_object_prepare($node);
      node_save($node);
    }
  }
}

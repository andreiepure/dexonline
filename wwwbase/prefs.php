<?php
require_once("../phplib/util.php");
require_once("../phplib/userPreferences.php");
util_assertNotLoggedIn();

$sendButton = util_getRequestParameter('send');

if ($sendButton) {
  $userPrefs = util_getRequestCheckboxArray('userPrefs', ',');
  $skin = util_getRequestParameter('skin');
  session_setAnonymousPrefs($userPrefs);
  if (session_isValidSkin($skin)) {
    session_setSkin($skin);
  }
  session_setFlash('Preferințele au fost salvate.', 'info');
  util_redirect('prefs.php');
} else {
  $userPrefs = session_getAnonymousPrefs();
  $skin = session_getSkin();
}

foreach (split(',', $userPrefs) as $pref) {
  if (isset($userPreferencesSet[$pref]) ) {
    $userPreferencesSet[$pref]['checked'] = true;
  }
}

smarty_assign('userPrefs', $userPreferencesSet);
smarty_assign('skin', $skin);
smarty_assign('availableSkins', session_getAvailableSkins());
smarty_assign('page_title', 'DEX online - Preferințe');
smarty_assign('show_search_box', 0);

smarty_displayCommonPageWithSkin('prefs.ihtml');
?>
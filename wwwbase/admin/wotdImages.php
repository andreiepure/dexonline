<?php
require_once("../../phplib/util.php");
util_assertModerator(PRIV_WOTD);
util_assertNotMirror();
RecentLink::add('Imaginea zilei');

SmartyWrap::addCss('elfinder', 'jqueryui', 'admin');
SmartyWrap::addJs('elfinder', 'jqueryui');
SmartyWrap::display('admin/wotdImages.tpl');
?>

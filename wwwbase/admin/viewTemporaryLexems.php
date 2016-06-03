<?php
require_once('../../phplib/util.php');
ini_set('memory_limit', '512M');
util_hideEmptyRequestParameters();
util_assertModerator(PRIV_EDIT);
util_assertNotMirror();

$sourceId = util_getRequestParameter('source');

if ($sourceId) {
  $source = Source::get_by_id($sourceId);
  RecentLink::createOrUpdate("Lexeme neetichetate {$source->shortName}");
  $lexems = Model::factory('Lexem')
    ->table_alias('l')
    ->select('l.*')
    ->distinct()
    ->join('LexemDefinitionMap', 'ldm.lexemId = l.id', 'ldm')
    ->join('Definition', 'd.id = ldm.definitionId', 'd')
    ->where('d.status', Definition::ST_ACTIVE)
    ->where('d.sourceId', $sourceId)
    ->where('l.modelType', 'T')
    ->order_by_asc('formNoAccent')
    ->limit(1000)
    ->find_many();
} else {
  RecentLink::createOrUpdate('Lexeme neetichetate');
  $lexems = Model::factory('Lexem')
    ->where('modelType', 'T')
    ->order_by_asc('formNoAccent')
    ->limit(1000)
    ->find_many();
}

SmartyWrap::assign('recentLinks', RecentLink::loadForUser());
SmartyWrap::assign('lexems', $lexems);
SmartyWrap::displayAdminPage('admin/viewTemporaryLexems.tpl');

?>

<?php

/* A fragment is a part of a compound lexem */

class Fragment extends BaseObject implements DatedObject {
  public static $_table = 'Fragment';

  const DEC_FULL = 1;
  const DEC_ARTICLE = 2;
  const DEC_NO_ARTICLE = 3;
  const DEC_INVARIABLE = 4;
  const DEC_INVARIABLE_PLURAL = 5;
  const DEC_INVARIABLE_DATIVE = 6;

  public static $DEC_NAMES = [
    self::DEC_FULL  => 'flexiune completă',
    self::DEC_ARTICLE  => 'articulat',
    self::DEC_NO_ARTICLE  => 'nearticulat',
    self::DEC_INVARIABLE  => 'invariabil',
    self::DEC_INVARIABLE_PLURAL  => 'invariabil plural',
    self::DEC_INVARIABLE_DATIVE  => 'invariabil dativ',
  ];

  // Helper table that translates compound inflections into fragment inflections.
  // "null" means "the fragment mimics the compound inflection".
  public static $INV_RULES = [
    self::DEC_FULL => [
      'gender' => null,
      'number' => null,
      'case' => null,
      'article' => null,
    ],
    self::DEC_ARTICLE => [
      'gender' => null,
      'number' => null,
      'case' => null,
      'article' => Inflection::ARTICLE_DEFINITE,
    ],
    self::DEC_NO_ARTICLE => [
      'gender' => null,
      'number' => null,
      'case' => null,
      'article' => Inflection::ARTICLE_NONE,
    ],
    self::DEC_INVARIABLE => [
      // no restrictions -- ordering by inflection rank should suffice
    ],
    self::DEC_INVARIABLE_PLURAL => [
      'number' => Inflection::NUMBER_PLURAL,
      'case' => Inflection::CASE_NOMINATIVE,
      'article' => Inflection::ARTICLE_NONE,
    ],
    self::DEC_INVARIABLE_DATIVE => [
      'number' => Inflection::NUMBER_SINGULAR,
      'case' => Inflection::CASE_DATIVE,
      'article' => Inflection::ARTICLE_DEFINITE,
    ],
  ];

  static function create($partId, $declension, $capitalized, $rank) {
    $f = Model::factory('Fragment')->create();
    $f->partId = $partId;
    $f->declension = $declension;
    $f->capitalized = $capitalized;
    $f->rank = $rank;
    return $f;
  }

  // Given
  //
  // * the desired inflection for the compound lexeme,
  // * the model type of the part lexeme,
  // * and the declension type for the part lexeme,
  //
  // decide which inflection of the part lexeme we need to look at
  static function getInflection($infl, $partModelType, $declension) {
    $query = Model::factory('Inflection')
           ->table_alias('i')
           ->select('i.*')
           ->join('ModelType', ['i.modelType', '=', 'mt.canonical'], 'mt')
           ->where('mt.code', $partModelType);

    foreach (self::$INV_RULES[$declension] as $field => $value) {
      if ($value === null) {
        $value = $infl->$field; // mimic compund inflection
      }
      $query = $query->order_by_expr("(`{$field}` = {$value}) desc");
    }

    return $query->order_by_asc('i.rank')->find_one();
  }
}

?>
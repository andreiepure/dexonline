{assign var="cuv" value=$cuv|default:''}
{assign var="onHomePage" value=$onHomePage|default:false}
{assign var="suggestHiddenSearchForm" value=$suggestHiddenSearchForm|default:false}
{assign var="suggestNoBanner" value=$suggestNoBanner|default:false}
<!DOCTYPE html>
<html>
  <head>
    <title>{block name=title}Dicționare ale limbii române{/block} | dexonline</title>
    <meta charset="utf-8" />
    <meta content="initial-scale=1.0, maximum-scale=3.0, user-scalable=yes" name="viewport">
    {block name=pageDescription}{/block}
    {block name=openGraph}
      <meta property="og:image" content="{$imgRoot}/logo-dexonline-2.png" />
      <meta property="og:type" content="website" />
      <meta property="og:title" content="dexonline" />
      <link rel="image_src" href="{$imgRoot}/logo-dexonline-2.png" />
    {/block}
    {include file="bits/cssJs.tpl"}
    <link rel="search" type="application/opensearchdescription+xml" href="https://dexonline.ro/download/dex.xml" title="Căutare dexonline.ro"/>
    <link href="https://plus.google.com/100407552237543221945" rel="publisher" />
    <link rel="alternate" type="application/rss+xml" title="Cuvântul zilei" href="https://dexonline.ro/rss/cuvantul-zilei">
    <link rel="apple-touch-icon" href="{$imgRoot}/apple-touch-icon.png">
  </head>

  <body {if !$onHomePage}class="secondary"{/if}>
    {if !$suggestNoBanner && $skinVariables.responsiveBanner}
      {include file="bits/responsiveBanner.tpl"}
    {/if}

    {if $skinVariables.fullMenu}
      <header id="menu" class="bendShadow">
        {if !$onHomePage}
          <a href="{$wwwRoot}" id="homeLink" title="Pagina principală dexonline"></a>
        {/if}
        <div class="socialPlugins">
          <div class="fbTop">
            {include file="bits/facebookButton.tpl"}
          </div>
          <div class="plusTop">
            <script src="https://apis.google.com/js/platform.js" async defer></script>
            <g:plusone size="medium" href="https://dexonline.ro"></g:plusone>
          </div>
        </div>
        <ul id="mainMenu">
          <li><a href="#" onclick="return false;">Despre noi</a>
            <ul>
              <li><a href="http://wiki.dexonline.ro/wiki/Informa%C8%9Bii" target="_blank">Informații</a></li>
              <li><a href="{$wwwRoot}contact">Contact</a></li>
              <li><a href="http://dexonline.blogspot.ro">Blogul nostru</a></li>
            </ul>
          </li>
          <li><a href="#" onclick="return false;">Implică-te</a>
            <ul>
              <li><a href="{$wwwRoot}contribuie">Contribuie cu definiții</a></li>
              <li><a href="{$wwwRoot}top">Topul voluntarilor</a></li>
              <li><a href="http://wiki.dexonline.ro/wiki/Informa%C8%9Bii_pentru_programatori">Informații pentru programatori</a></li>
            </ul>
          </li>
          <li><a href="#" onclick="return false;">Articole și resurse</a>
            <ul>
              <li><a href="http://wiki.dexonline.ro/wiki/Abrevieri" target="_blank">Abrevieri folosite</a></li>
              <li><a href="{$wwwRoot}articole">Articole lingvistice</a></li>
              <li><a href="{$wwwRoot}articol/Ghid_de_exprimare_corect%C4%83">Ghid de exprimare</a></li>
              <li><a href="{$wwwRoot}cuvantul-zilei">Cuvântul zilei</a></li>
              <li><a href="{$wwwRoot}cuvantul-lunii">Cuvântul lunii</a></li>
              <li><a href="{$wwwRoot}cuvinte-aleatoare">Cuvinte aleatoare</a></li>
              <li><a href="{$wwwRoot}scrabble">Scrabble</a></li>
              <li><a href="{$wwwRoot}unelte">Unelte</a></li>
              <li><a href="{$wwwRoot}legaturi">Legături externe</a></li>
            </ul>
          </li>
          {if !$suggestHiddenSearchForm}
            <li class="donateLink"><a href="{$wwwRoot}doneaza">Donează</a></li>
          {/if}
          {if $isMobile}
            <li id="mobileLink"><a href="#">Versiunea pentru mobil</a></li>
          {/if}
        </ul>
        {if !$cfg.global.mirror}
          <ul id="userMenu">
            <li id="userNick"><div id="userPic"></div><a href="#" onclick="return false;">{$nick|escape}</a>
              <ul>
                {if $sUser && $sUser->moderator}
                  <li><a href="{$wwwRoot}admin">Pagina moderatorului</a></li>
                {/if}
                <li><a href="{$wwwRoot}preferinte">Preferințe</a></li>
                {if $sUser}
                  <li><a href="{$wwwRoot}utilizator/{$sUser->nick}">Profilul meu</a></li>
                  <li><a href="{$wwwRoot}cuvinte-favorite">Cuvinte favorite</a></li>
                  <li><a href="{$wwwRoot}auth/logout">Închide sesiunea</a></li>
                {else}
                  <li><a href="{$wwwRoot}auth/login">Autentificare cu OpenID</a></li>
                {/if}
              </ul>
            </li>
          </ul>
        {/if}
      </header>
      <div id="contentProper">
        {include file="bits/flashMessages.tpl"}

        {if !$onHomePage && !$suggestHiddenSearchForm && $skinVariables.searchForm}
          <section id="searchOtherPages">
            {include file="bits/searchForm.tpl"}
          </section>
        {/if}

        {if !$onHomePage && !$suggestNoBanner && $skinVariables.banner}
          {include file="bits/banner.tpl" id="otherPages" width="728" height="90"}
        {/if}

        <section>
          {block name=content}{/block}
        </section>

        {if !$onHomePage && $skinVariables.fbLarge}
          {include file="bits/facebook.tpl"}
        {/if}
      </div>
      {else}
        <header id="menu">
          <a href="http://wiki.dexonline.ro/wiki/Informa%C8%9Bii" target="_blank">Informații</a>
          <a href="{$wwwRoot}articole">Articole</a>
          <a href="{$wwwRoot}preferinte">Preferințe</a>
        </header>
        <div id="contentProper">
          {if $onHomePage}
            <div id="logoHomePage">
              <img src="{$wwwRoot}img/mobile/logo-dexonline-60.png" alt="logo dexonline.ro" />
            </div>
          {else}
            <div id="logoOtherPages">
              <a href="{$wwwRoot}"><img src="{$wwwRoot}img/mobile/logo-dexonline-30.png" alt="logo dexonline.ro" /></a>
            </div>
          {/if}
          {if !$suggestHiddenSearchForm}
            <div id="searchArea">
              <form action="{$wwwRoot}search.php" name="frm" class="searchForm" onsubmit="return searchSubmit()">
                <input type="search" name="cuv" size="15" value="{$cuv|escape}" maxlength="50" id="searchField" autocomplete="off" autofocus />
                <span><input type="submit" value="caută" id="searchButton" /></span>
              </form>
            </div>
          {/if}
          {block name=content}{/block}
        </div>
      {/if}

    <footer>
      <ul>
        {if $isMobile}
          <li id="desktopLink" data-skin="{$cfg.global.desktopSkin}"><a href="#">Versiunea pentru desktop</a></li>
        {/if}
        <li>Copyright (C) 2004-{$currentYear} dexonline (https://dexonline.ro)</li>
        <li class="licenceLink"><a href="{$wwwRoot}licenta">Licență</a></li>
        {if $cfg.global.hostedBy}
          <li class="hostingLink">{include file="hosting/`$cfg.global.hostedBy`.tpl"}</li>
        {/if}
      </ul>
    </footer>
    {include file="bits/analytics.tpl"}
    {getDebugInfo}
  </body>
</html>

<div class="form-group">

  <button type="submit"
          name="refreshButton"
          class="lexemEditSaveButton btn btn-primary">
    <i class="glyphicon glyphicon-refresh"></i>
    <u>r</u>eafișează
  </button>

  <button type="submit"
          name="saveButton"
          class="lexemEditSaveButton btn btn-success">
    <i class="glyphicon glyphicon-floppy-disk"></i>
    <u>s</u>alvează
  </button>

  {if $canEdit.general}
    <button type="submit"
            name="cloneButton"
            class="btn btn-default">
      <i class="glyphicon glyphicon-duplicate"></i>
      clonează
    </button>
  {/if}

  <a href="?lexemId={$lexem->id}">renunță</a>

  {if $canEdit.loc || !$lexem->isLoc}
    <button type="submit"
            name="deleteButton"
            onclick="return confirm('Confirmați ștergerea acestui lexem?');"
            class="btn btn-danger pull-right"
            {if $lexem->isLoc}disabled="disabled"{/if}>
      <i class="glyphicon glyphicon-trash"></i>
      șterge
    </button>
  {/if}
  
</div>

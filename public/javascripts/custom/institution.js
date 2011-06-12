/**
 * Institution select
 *
 * How it works :
 * 1. When blank (new offer for example)
 *   - The institution name field is displayed
 *   - The user starts to type in the name of its institution (company / school...)
 *   - If the user selects an institution :
 *     - The institution name gets fixed (fixInstitutionName)
 *     - The institution id gets set to the id of the selected one
 *   - If the user selects "Add institution" OR get outside the field (tab, click...)
 *     - The institution form (url, category1, category2, location) gets displayed
 *     - The institution id is set to blank
 * 2. When already set
 *   - The fixed institution is displayed
 *   - The institution id is set to the selected institution
 *   - If the user clicks on the "Change" link, we are back at 1 : fields are all blanked
 */
$(document).ready(function(){
  // initialize function
  $.fn.institutionInitialize = function(css_class) {
    // shortcut to institution id, name and fieldset
    input_id = $('.' + css_class).find('input[name$="[institution_id]"]');
    input_name = $('.' + css_class).find('input[name$="[name]"]');
    institution_fieldset = $('.' + css_class);
    new_institution_li = institution_fieldset.find('.new_institution_field');

    // prepare add form
    if(
        (
        input_id.val() // institution is already selected
        || (!input_id.val() && !input_name.val()) // no institution id or name
        )
        && (!new_institution_li.find('.inline-errors').size()) // error in institution form
      )
    {
      new_institution_li.hide();
    }
    input_name.parents().show();

    /**
     * Change institution name to string with change toggle
     */
    function fixInstitutionName()
    {
      // check if id is set
      if(input_id.val())
      {
        input_name.hide();
        new_institution_li.hide();
        if(!institution_fieldset.find('.frozen-institution-name').size())
        {
          input_name.after('\
            <span class="frozen-institution-name">\
              <span class="name">' + input_name.val() + '</span>\
              <span class="link-edit"><a href="#">Modifier</a></span>\
            </span>\
          ');
          
          // behavior
          institution_fieldset.find('.frozen-institution-name .link-edit a').unbind('click').click(function(e){
            e.preventDefault();
            // remove static
            input_name.show();
            institution_fieldset.find('.frozen-institution-name').remove();
            // clean all fields
            cleanAddFields();
            // clear fields
            input_name.val(null);
            input_name.focus();
            // remove errors
            institution_fieldset.find('.inline-errors').remove();
          });
        }
      }
    }
    fixInstitutionName();

    /**
     * Reset all fields (except name)
     */
    function cleanAddFields()
    {
      institution_fieldset.find('input').not('input[name$="[name]"]').val('');
    }

    // autocomplete options
    options = {
      select:  function(event, ui) {
        if((typeof(ui.item.id) != 'undefined') && ui.item.id)
        {
          input_id.val(ui.item.id);
          fixInstitutionName();
        }
        else
        {
          // new selected : display new institution form fields
          new_institution_li.show();
          cleanAddFields();
          input_name.val(ui.item.value);
        }
        //find('.sff_institution_selected_id').val()
      },
      source:  function(request, response) {
        $.getJSON(
          '/institutions/search.json?term=' + request.term,
          function(data){
             list = [];
             for(var i = 0; i < data.length; i++)
             {
               //alert($.dump(data[i].institution.name));
               list[i] = {
                 /*
                 label: '\
                 <span class="sff-x-institution">\
                   <span class="name">' + data[i].name + '</span>\
                   <span class="category1">' + data[i].category1 + '</span>\
                   <span class="location">' + data[i].location + '</span>\
                 </span>',
                 */
                 label: data[i].institution.name,
                 value: data[i].institution.name,
                 id: data[i].institution.id
               };
             }

             if(request.term)
             {
               label = 'Ajouter __name__';
               label = label.replace('__name__', request.term);
               list[i] = {
                 /* label: '\
                 <span class="sff-x-institution sff-x-institution-add">\
                   <span class="name">' + label + '</span>\
                   <span class="category1">&nbsp;</span>\
                   <span class="location">&nbsp;</span>\
                 </span>',
                 */
                 label: label,
                 value: request.term
               };
             }

            response(list);
          });
      }
    };

    input_name.autocomplete(options);
    // on type
    // disable if enter or tab
    /*
    institution_fieldset.jkey('enter',function(){ // tab ?
      //fixInstitutionName();
      //cleanAddFields();
    });
    */
    // on lost focus
    input_name.blur(function(e){
      fixInstitutionName();
      //cleanAddFields();
    });
  }
});
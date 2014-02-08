$ ->
  idea_description_note = $('#idea_description')

  idea_description_note.summernote {
    height: 370
    toolbar: [
                ["style", ["style"]],
                ["style", ["bold", "italic", "underline", "clear"]],
                ["para", ["ul", "ol"]],
                ['insert', ['picture', 'link']],
                ['view', ['fullscreen']]
             ]
    onImageUpload: (files, editor, welEditable) ->
      for file in files
        Qiniu.sendFile file, (url) ->
          editor.insertImage(welEditable, url)
  }

  # to set code for summernote
  idea_description_note.code idea_description_note.val()

  # to get code for summernote
  idea_description_note.closest('form').submit ->
    idea_description_note.val idea_description_note.code()
    true


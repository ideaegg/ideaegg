$ ->
  post_content_note = $('#post_content')

  post_content_note.summernote {
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
  post_content_note.code post_content_note.val()

  # to get code for summernote
  post_content_note.closest('form').submit ->
    post_content_note.val post_content_note.code()
    true


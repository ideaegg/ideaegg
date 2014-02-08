class Qiniu
  @sendFile: (file, callback) ->
    formData = new FormData()
    formData.append('file', file)

    $.get '/uploads/uptoken.json', (data) ->
      formData.append('token', data.uptoken)

      $.ajax {
        url: 'http://up.qiniu.com/',
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        type: 'POST',
        success: (data) ->
          url = "http://ideaegg.qiniudn.com/#{data.key}"
          callback(url)
      }

@Qiniu = Qiniu

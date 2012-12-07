return unless location.pathname == '/'
jQuery ($) ->
  s = new EventSource('/streams/comments')
  s.addEventListener 'message', (e) ->
    ((e)->
      comment = $.parseJSON(e.data)
      $('#comments').prepend(
        $('<tr>').append(
          $('<td>').attr('class', 'span10').text(comment.body)
        ).append(
          $('<td>').text(comment.created_at.replace('T', ' ').replace(/:\d\dZ/, ''))
        )
      )
    )(e)
  , false

  window.onbeforeunload = () ->
    s.close()

  $("#send_comment").on 'click', () ->
    $.post(@form.action + '.json', $(@form).serialize())
      .success (response)->
         console.log "success"
      .error (response) ->
         console.log response

    return false

$('.edit').on('click', function () {
  var _id = $(this).attr('data-id'),
      _url = '/apis/' + _id + '/detail';
  $('#editModal').on('show.bs.modal', function (e) {
    $.get(_url, function(response){
      var api = response.api;
      $('#edit_url').val(api.url);
      $('#edit_comment').val(api.comment);
      $('#edit_method').val(api.method);
      $('#edit_data').val(api.data);
    });

    updateData(_id);
  }).modal('show');
});

function updateData(id){
  $('#update').on('click', function () {
    $(this).attr('disabled', true);
    _url = '/apis/' + id;
    $.ajax({
      url: _url,
      type: 'PUT',
      dataType: "json",
      data: {
        'url': $('#edit_url').val(),
        'method': $('#edit_method').val(),
        'comment': $('#edit_comment').val(),
        'data': JSON.parse($('#edit_data').val())
      },
      success: function(response) {
        if (response.success) {
          $('#tip').show();
          setInterval(function(){
            $('#editModal').modal('hide');
          }, 3000);
          window.location.href = '/apis';
        }
      }
    });
    $(this).attr('disabled', false);
  });
}

$('.remove').on('click', function () {
  var _id = $(this).attr('data-id'),
      _url = '/apis/' + _id;
  $('#removeModal').modal('show');
  $('#confirmRemove').on('click', function () {
    $.ajax({
      url: _url,
      type: 'DELETE',
      dataType: "json",
      success: function(response) {
        if (response.success) {
          $('#removeModal').modal('hide');
          $('#api-'+_id).remove();
        }
      }
    });
  });
});

$('#create').on('click', function () {
  $.ajax({
    url: '/apis',
    type: 'POST',
    dataType: 'json',
    data: {
      'url': $('#url').val(),
      'comment': $('#comment').val(),
      'method': $('#method').val(),
      'data': JSON.parse($('#data').val())
    },
    success: function(response) {
      if (response.success) {
        window.location.href = '/apis';
      }
    }
  });
});

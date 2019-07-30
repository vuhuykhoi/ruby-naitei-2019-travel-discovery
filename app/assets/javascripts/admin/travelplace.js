$( document ).ready(function() {
  const csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': csrfToken
    }
  });

  $('#add-Travel').click(function(){
    $('#name').val('');
    $('#content').val('');
    $('#address').val('');
  });

  $('#addTravelPlace').on('submit', function(event){
    event.preventDefault();
    $.ajax({
        url:"/admin/travelplaces/",
        type:"POST",
        data:{
          name: $('#name').val(),
          content: $('#content').val(),
          address: $('#address').val(),
          address: $('#address').val(),
          type_travel_place_id: $( "#types" ).val(),
          city_id: $( "#cities" ).val()
        },
        dataType:"json",
        success:function(data)
        {
          toastr["success"](I18n.t("admin.travelplaces.index.add_success"), I18n.t("admin.travelplaces.index.notification"));
          $('#addTravelPlace')[0].reset();
          $('#action').val('Add');
          $('#addcity').modal('hide');
          window.location.reload();
        }
    })
  });

  $(document).on('click','.edit-travel',(function(){
    var id = $(this).attr('travel-id');
    $.ajax({
      type:'get',
      url:"/admin/travelplaces/"+id+"/edit",
      dataType: "json",
      success:function(response){
        $('#form-edit-travel').attr('data-id',response.id);
        $("input[name='name']").val(response.name);
        $("input[name='content']").val(response.content);
        $("input[name='address']").val(response.address);
      }
    })
  })
  );

  $('#form-edit-travel').submit(function(e){
    e.preventDefault();
    var id = $(this).attr('data-id');
    console.log(id);
    $.ajax({
      type:'put',
      url:"/admin/travelplaces/"+id,
      data:{
        name: $('#name').val(),
        content: $('#content').val(),
        address: $('#address').val(),
        address: $('#address').val(),
        type_travel_place_id: $( "#types" ).val(),
        city_id: $( "#cities" ).val()
      },
      success:function(response){
        toastr["success"](I18n.t("admin.travelplaces.index.edit_success"), I18n.t("admin.travelplaces.index.notification"))
        $('#edittravel').modal('hide');
      }
    })
  });

  $(document).on('click','.travel-delete',(function(){
    var id = $(this).attr('travel-id');
    swal({
      title: I18n.t("admin.travelplaces.index.question"),
      text: I18n.t("admin.travelplaces.index.note"),
      icon: "warning",
      buttons: true,
      dangerMode: true,
    })
    .then((willDelete) => {
      if (willDelete) {
        $.ajax({
            type:'delete',
            url:"/admin/travelplaces/"+id,
        })
        swal(I18n.t("admin.travelplaces.index.notice_true"), {
            icon: "success",
        });
        window.location.reload();
        } else {
          swal(I18n.t("admin.travelplaces.index.notice_fails"));
        }
      });
    })
  );

});

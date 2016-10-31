$(document).ready(function () {
    $('#semester-select').on('change', function(){
        console.log($(this).val());
        $.ajax({
            url: '/courses/search',
            method: 'POST',
            dataType: 'json',
            data: {semester_id : $(this).val()}
        }).done(function(res){
            console.log(res);
            var html =''
            var a=''
            $.each(res, function(index, elm){
                console.log(elm);
                a +=                    '<tr>' +
                                            '<td class="text-center text-capitalize">'+elm[0]+'</td>' +
                                            '<td>'+elm[1]+'</td>' +
                                            '<td class="text-center">'+elm[2]+'</td>' +
                                            '<td class="text-center">'+elm[3]+'</td>' +
                                        '</tr>'

            });

            html = '<div class="container">' +
                        '<div class="table-responsive">' +
                            '<table class="table">' +
                                '<thead>' +
                                    '<tr>' +
                                        '<th class="text-center">Course Name</th>' +
                                        '<th >Description</th>' +
                                        '<th class="text-center">Credit</th>' +
                                        '<th class="text-center">Achieved Grade</th>' +
                                    '</tr>' +
                                '</thead>' +
                                '<tbody>' +
                                            a
                                        +
                                '</tbody>' +
                             '</table>' +
                        '</div>' +
                    '</div>'
            $('#result-div').html(html);
        }).error(function(err){
            console.log(err);
        })
    });

    dataConfirmModal.setDefaults({
        title: 'You are about to delete this course.',
        commit: 'Yes',
        cancel: 'No'
    });
});


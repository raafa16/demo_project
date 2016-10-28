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
            var html = ''
            $.each(res, function(index, elm){
                console.log(elm);
                html += '<div class="container">' +
                            '<div class="table-responsive">' +
                                '<table class="table">' +
                                    '<thead>' +
                                        '<tr>' +
                                            '<th>#</th>' +
                                            '<th>Course Name</th>' +
                                            '<th>Description</th>' +
                                            '<th>Credit</th>' +
                                            '<th>Achieved Grade</th>' +
                                        '</tr>' +
                                    '</thead>' +
                                    '<tbody>' +
                                        '<tr>' +
                                            '<td>elm[0]</td>' +
                                            '<td>elm[1]</td>' +
                                            '<td>elm[2]</td>' +
                                            '<td>elm[3]</td>' +
                                        '</tr>' +
                                    '</tbody>' +
                                    '</table>' +
                            '</div>' +
                        '</div>'
            });
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


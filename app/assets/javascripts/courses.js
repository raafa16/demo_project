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
                html += '<h3>Course Name: '+ elm['name'] +', Credit: '+ elm['credit'] +' </h3>'
            });
            $('#result-div').html(html);
        }).error(function(err){
            console.log(err);
        })
    });
});
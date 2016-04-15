$(function() {

    $('#login-form-link').click(function(e) {
        $("#login-form").delay(100).fadeIn(100);
        $("#register-form").fadeOut(100);
        $('#register-form-link').removeClass('active');
        $(this).addClass('active');
        e.preventDefault();

        $('form[name="login"]').removeClass("Hidden");
        $('form[name="signup"]').addClass("Hidden");
    });
    $('#register-form-link').click(function(e) {
        $("#register-form").delay(100).fadeIn(100);
        $("#login-form").fadeOut(100);
        $('#login-form-link').removeClass('active');
        $(this).addClass('active');
        e.preventDefault();

        $('form[name="login"]').addClass("Hidden");
        $('form[name="signup"]').removeClass("Hidden");
    });

        var path = window.location.pathname;
    if (path.indexOf('sign_out') > -1 ||
        path.indexOf('sign_in') > -1)
    {
        $('#signoutLink').addClass('Hidden');
        $('#login-form-link').trigger('click');
    }
    else{
        $('#signoutLink').removeClass('Hidden');
        $('#register-form-link').trigger('click');
    }

});


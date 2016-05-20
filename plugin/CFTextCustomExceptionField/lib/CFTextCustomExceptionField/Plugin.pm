package CFTextCustomExceptionField::Plugin;
use strict;

our $plugin = MT->component( 'CFTextCustomExceptionField' );

sub _cb_tp_edit_contactform {
    my ( $cb, $app, $param, $tmpl ) = @_;
    $param->{ js_include } .= <<'EOF';
<script type="text/javascript">
(function(j) {
  var typeOfTextCustomException = {
    text_custom_exception: {
      visibility: {
        opt: true,
        size: false,
        def: true,
        validate: true,
        length: true
      },
      defaultType: 'text'
    }
  };
  j.contactForm.addType(typeOfTextCustomException);
})(jQuery);
</script>
EOF
}


sub _validate_text_custom_exception {
    my ( $app, $contactform, $value, $params ) = @_;
    if ( ( ref $value ) eq 'ARRAY' ) {
        $value = @$value[0];
    }

    if (! $value ) {
        return 0;
    }
    #empty.

    my $exception_options = $contactform->options . ",";

    if ( index( $contactform->options, 'numeric,' ) ){   #数値のみか.
        unless ($value =~ /^[0-9]+$/) {
            return 0;
        }
    }
    elsif ( index( $contactform->options, 'hiragana,' ) ){   #ひらがなのみか.
        if ( $str =~ /^(?:\xE3\x81[\x81-\xBF]|\xE3\x82[\x80-\x93])+$/ ) {
                return 0;
        }
    }
    elsif ( index( $contactform->options, 'em_katakana,' ) ){   #全角カタカナのみか.
        if ( $str =~ /^(?:\xE3\x82[\xA1-\xBF]|\xE3\x83[\x80-\xB6])+$/ ) {
            return 0;
        }
    }
    elsif ( index( $contactform->options, 'em,' ) ){ #全角文字のみか.
        if ( $str !~ /(?:\xEF\xBD[\xA1-\xBF]|\xEF\xBE[\x80-\x9F])|[\x20-\x7E]/ ) {
            return 0;
        }
    }
    elsif ( index( $contactform->options, 'ascii,' ) ){ #全角文字が含まれないか（ASCII文字のみか）.
        if ( $str =~ /^[\x20-\x7E]+$/ ) {
            return 0;
        }
    }

    return 1;
}

1;


=pod
sub _cb_contactform_pre_build_extra_text {
    my ( $cb, $app, $mtml, $args, $params ) = @_;
    my $ctx = $args->{ ctx };
    my $contactform = $ctx->stash( 'contactform' );
    my $basename = $contactform->basename;
    my $default = build_tmpl( $app, $contactform->default, $args, $params );
    if ( $default ) {
        $default =~ s/,//g;
    }

}
=cut

=pod
sub _format_extra_text {
    my ( $app, $contactform ) = @_;
    my $basename = $contactform->basename;
    my $hidden = $app->param( $basename );
    if ( $hidden ) {
        if ( valid_ts( $hidden ) ) {
            return $hidden;
        } else {
            $app->param( $basename, undef );
        }
    }

}
=cut

1;
class development {

    include base
    include nodejs

    package { 'git':
        ensure      => latest,
    }

}

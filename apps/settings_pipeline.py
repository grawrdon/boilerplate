PIPELINE_VERSION_REMOVE_OLD = True

PIPELINE_CSS = {

    'core-styles': {
        'source_filenames': (
            'less/project.less',
        ),
        'output_filename': 'compiled/css/screen.grouped.css',
        'extra_context': {
            'media': 'all',
        },
    },

}

PIPELINE_JS = {

    'modernizr': {
        'source_filenames': (
            'lib/modernizr/modernizr.base.js',
        ),
        'output_filename': 'compiled/js/modernizr.custom.js',
    },

}


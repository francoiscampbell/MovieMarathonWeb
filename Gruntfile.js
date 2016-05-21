/**
 * Created by francois on 2016-05-21.
 */
module.exports = function (grunt) {
    grunt.loadNpmTasks('grunt-wiredep');

    grunt.initConfig({
        wiredep: {
            task: {
                // Point to the files that should be updated when
                // you run `grunt bower-install`
                src: [
                    'grails-app/views/**/*.gsp'
                ]
            },
            options: {
                fileTypes: {
                    gsp: {
                        block: /(([ \t]*)<!--\s*bower:*(\S*)\s*-->)(\n|\r|.)*?(<!--\s*endbower\s*-->)/gi,
                        detect: {
                            js: /<script.*src=['"]([^'"]+)/gi,
                            css: /<link.*href=['"]([^'"]+)/gi
                        },
                        replace: {
                            js: '<asset:javascript src="{{filePath}}"/>',
                            css: '<asset:stylesheet src="{{filePath}}"/>'
                        }
                    }
                }
            }
        }
    });
};

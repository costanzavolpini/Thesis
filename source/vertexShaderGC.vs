#version 330 core
// Vertex Shader for gaussian curvature
    layout (location = 0) in vec3 aPos;
    layout (location = 2) in vec3 gaussian_curvature;

    out vec4 color;

    uniform mat4 model;
    uniform mat4 view;
    uniform mat4 projection;


    vec3 interpolation(vec3 v0, vec3 v1, float t) {
        return (1 - t) * v0 + t * v1;
    }

    vec4 get_result_color_gc(){
       float val = gaussian_curvature[0]; // gaussian_curvature is a vec3 composed by same value
       vec3 red = vec3(1.0, 0.0, 0.0);
       vec3 green = vec3(0.0, 1.0, 0.0);
       vec3 blue = vec3(0.0, 0.0, 1.0);

       if (val < 0) { //negative numbers until 0 -> map from red to green
            return vec4(interpolation(red, green, val), 1.0);
        } else { //map from green to blue, from 0 to positive
            return vec4(interpolation(green, blue, val), 1.0);
        }
    }

    void main() {
        vec3 pos = vec3(model * vec4(aPos, 1.0));

        color = get_result_color_gc(); //vertex color obtained using gaussian curvature

        gl_Position = projection * view * model * vec4(aPos, 1.0);
    }


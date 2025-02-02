private void register_line_area() {
    Test.add_func("/LineArea/should_draw_a_straight_line_area", () => {
        //Given
        var context = create_context();

        var values = new LiveChart.Values();
        //Two points to draw an horizontal line
        values.add({timestamp: (GLib.get_real_time() / 1000) - 10000, value: 5.5});
        values.add({timestamp: (GLib.get_real_time() / 1000), value: 5.5});

        var line = new LiveChart.LineArea(values);
        line.line.color = Gdk.RGBA() {red = 1.0f, green = 0.0f, blue = 0.0f, alpha = 1.0f };
        line.area_alpha = 0.5f;

        //When
        line.draw(context.ctx, create_config());
 
        //Then
        //First fourth row as background
        has_only_one_color_at_row(context)(DEFAULT_BACKGROUND_COLOR, 0);
        has_only_one_color_at_row(context)(DEFAULT_BACKGROUND_COLOR, 1);
        has_only_one_color_at_row(context)(DEFAULT_BACKGROUND_COLOR, 2);
        has_only_one_color_at_row(context)(DEFAULT_BACKGROUND_COLOR, 3);
        //Line
        has_only_one_color_at_row(context)({ 1f, 0f, 0f, 1f }, 4);
        //Area
        has_only_one_color_at_row(context)({ 1f, 1f, 1f, 0.5f }, 0);
        has_only_one_color_at_row(context)({ 1f, 1f, 1f, 0.5f }, 1);
        has_only_one_color_at_row(context)({ 1f, 1f, 1f, 0.5f }, 2);
        has_only_one_color_at_row(context)({ 1f, 1f, 1f, 0.5f }, 3);
    });

    Test.add_func("/LineArea/should_not_render_anything_if_no_values", () => {
        //Given
        var context = create_context();

        var values = new LiveChart.Values();
       
        var line = new LiveChart.LineArea(values);
        line.line.color = Gdk.RGBA() {red = 1.0f, green = 0.0f, blue = 0.0f, alpha = 1.0f };

        //When
        line.draw(context.ctx, create_config());
 
        //Then
        assert_true(has_only_one_color(context)(DEFAULT_BACKGROUND_COLOR));
    });
    
    Test.add_func("/LiveChart/LineArea/Draw#should_render_all_points", () => {
        //Given
        var WIDTH = 100;
        var HEIGHT = 100;
        Cairo.ImageSurface surface = new Cairo.ImageSurface(Cairo.Format.ARGB32, WIDTH, HEIGHT);
        Cairo.Context context = new Cairo.Context(surface);
        cairo_background(context, { 0f, 0f, 0f, 1f }, WIDTH, HEIGHT);

        var values = new LiveChart.Values();
        values.add({timestamp: (GLib.get_real_time() / 1000), value: 0});
        values.add({timestamp: (GLib.get_real_time() / 1000) - 3600, value: 100});
        values.add({timestamp: (GLib.get_real_time() / 1000) - 7200, value: 0});
        values.add({timestamp: (GLib.get_real_time() / 1000) - 10800, value: 100});
        values.add({timestamp: (GLib.get_real_time() / 1000) - 14400, value: 0});

        var area = new LiveChart.LineArea(values);
          
        area.line.color = Gdk.RGBA() {red = 1.0f, green = 0.0f, blue = 0.0f, alpha = 0.5f };
        area.area_alpha = 0.5f;

        //When
        area.draw(context, create_config(WIDTH, HEIGHT));
 
        //Then
        //var pixbuff = Gdk.pixbuf_get_from_surface(surface, 0, 0, WIDTH, HEIGHT) ;

       //assert(color_at(pixbuff, WIDTH, HEIGHT)(35, 50).to_string() == "rgb(128,0,0)");
        //assert(color_at(pixbuff, WIDTH, HEIGHT)(57, 50).to_string() == "rgb(0,0,0)");
        //assert(color_at(pixbuff, WIDTH, HEIGHT)(80, 50).to_string() == "rgb(128,0,0)");
    });      
}
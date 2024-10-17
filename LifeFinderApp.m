classdef LifeFinderApp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure  matlab.ui.Figure
        QuestionLabel matlab.ui.control.Label
        Option1Button matlab.ui.control.Button  % Changed here
        Option2Button matlab.ui.control.Button  % Changed here
        Option3Button matlab.ui.control.Button  % Changed here
        MessageLabel matlab.ui.control.Label
        QuestionNumber = 1
        PlanetModel % Placeholder for planet 3D model
    end
    
    % Define questions and options
    properties (Constant)
        Questions = {
            'Does the planet have liquid water?', ...
            'Is the atmosphere breathable?', ...
            'Does the planet receive sunlight?', ...
            'Are there signs of organic materials?', ...
            'Are the temperatures just right?'
        };
        
        Options = {
            {'Yes, lots of it!', 'Absolutely not!', 'Only in my imagination!'}, ...
            {'Sure, as fresh as a daisy!', 'Nope, can’t breathe there!', 'Only if you can hold your breath!'}, ...
            {'Like a tanning salon!', 'Not a chance!', 'Only by moonlight!'}, ...
            {'Organic? You mean organic pizza?', 'Not a shred!', 'Maybe a noodle!'}, ...
            {'Perfect, like a microwave oven!', 'Ice age alert!', 'Too hot to handle!'}
        };
        
        HumorousResponses = {
            'Water? Sign us up for a beach day!','No? Better pack our bags!', ...
            'Sunshine! Where’s the sunscreen?', 'Nope, we’re heading back!',...
            'Organic pizza? yum!','No green light for life!',...
            'Temperatures? Ideally, just like my grandma’s cookies!', 'Better take a chance on global cooling!'
        };
    end

    % Construct app
    methods (Access = private)

        function startupFcn(app)
            app.createPlanet();
            app.updateQuestion();
        end

        function createPlanet(app)
            % Create 3D planet representation (in a simplified form)
            [x,y,z] = sphere(50);
            surf(x,y,z,'FaceColor','b','EdgeColor','none'); hold on;
            axis equal;
            title('Planet Visualization');
            xlabel('X-axis');
            ylabel('Y-axis');
            zlabel('Z-axis');
            view(3);
            grid on;
            app.PlanetModel = gca; % Storing current axis as planet model
        end

        function updateQuestion(app)
            % Update the user interface with the current question and options
            if app.QuestionNumber <= length(app.Questions)
                app.QuestionLabel.Text = app.Questions{app.QuestionNumber};
                app.Option1Button.Text = app.Options{app.QuestionNumber}{1};
                app.Option2Button.Text = app.Options{app.QuestionNumber}{2};
                app.Option3Button.Text = app.Options{app.QuestionNumber}{3};
                % Handle the visual change of the planet based on question number
                app.changePlanetAppearance();
            else
                app.finalResult();
            end
        end

        function changePlanetAppearance(app)
            % Adjust the planet's appearance based on responses
            switch app.QuestionNumber
                case 1
                    set(app.PlanetModel, 'Color', [0 0 1]); % Blue for water
                    app.showMessage('Feeling quite hydrated!');
                case 2
                    set(app.PlanetModel, 'Color', [1 1 0]); % Yellow for breathable atmosphere
                    app.showMessage('Breathe in the good vibes!');
                case 3
                    set(app.PlanetModel, 'Color', [1 0 0]); % Red for receiving sunlight
                    app.showMessage('Get your sunglasses ready!');
                case 4
                    set(app.PlanetModel, 'Color', [0 1 0]); % Green for organic materials
                    app.showMessage('Organic life in the making!');
                case 5
                    set(app.PlanetModel, 'Color', [0 0 0]); % Black for extreme temperatures
                    app.showMessage('Way too hot or cold!');
            end
        end

        function showMessage(app, message)
            % Simple message display for user interaction
            app.MessageLabel.Text = message;  % Update the label instead of creating a new uicontrol
        end
        
        function finalResult(app)
            % Final result presentation
            msg = 'Congratulations! You just discovered a new planet with life potential!';
            msgbox(msg, 'Result', 'modal');
        end
        
        % Button functions for options
        function Option1ButtonPushed(app)
            app.QuestionNumber = app.QuestionNumber + 1;
            app.updateQuestion();
        end

        function Option2ButtonPushed(app)
            app.QuestionNumber = app.QuestionNumber + 1;
            app.updateQuestion();
        end

        function Option3ButtonPushed(app)
            app.QuestionNumber = app.QuestionNumber + 1;
            app.updateQuestion();
        end
    end

    % App initialization and construction
    methods (Access = public)

        % Construct app
        function app = LifeFinderApp
            % Create and configure components
            app.UIFigure = uifigure('Position',[100 100 400 400]);
            app.QuestionLabel = uilabel(app.UIFigure, 'Position',[50 300 300 40], 'FontSize',16);
            app.MessageLabel = uilabel(app.UIFigure, 'Position',[50 50 300 40], 'FontSize',12); % Add label for messages
            app.Option1Button = uibutton(app.UIFigure, 'push', 'Text', 'Option1', ...
                                          'Position',[50, 220, 100, 30], ...
                                          'ButtonPushedFcn', @(src,event) app.Option1ButtonPushed());
            app.Option2Button = uibutton(app.UIFigure, 'push', 'Text', 'Option2', ...
                                          'Position',[150, 220, 100, 30], ...
                                          'ButtonPushedFcn', @(src,event) app.Option2ButtonPushed());
            app.Option3Button = uibutton(app.UIFigure, 'push', 'Text', 'Option3', ...
                                          'Position',[250, 220, 100, 30], ...
                                          'ButtonPushedFcn', @(src,event) app.Option3ButtonPushed());
            startupFcn(app);
        end
    end
end

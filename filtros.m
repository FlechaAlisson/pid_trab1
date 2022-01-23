function varargout = teste_guide(varargin)
% TESTE_GUIDE MATLAB code for teste_guide.fig
%      TESTE_GUIDE, by itself, creates a new TESTE_GUIDE or raises the existing
%      singleton*.
%
%      H = TESTE_GUIDE returns the handle to a new TESTE_GUIDE or the handle to
%      the existing singleton*.
%
%      TESTE_GUIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTE_GUIDE.M with the given input arguments.
%
%      TESTE_GUIDE('Property','Value',...) creates a new TESTE_GUIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before teste_guide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to teste_guide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help teste_guide

% Last Modified by GUIDE v2.5 17-Dec-2021 10:01:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @teste_guide_OpeningFcn, ...
                   'gui_OutputFcn',  @teste_guide_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before teste_guide is made visible.
function teste_guide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to teste_guide (see VARARGIN)

% Choose default command line output for teste_guide
handles.output = hObject;

handles.originalImage = imread('peppers.png');
handles.stackImage = {handles.originalImage};
set(handles.axes1,'Units','pixels');
axes(handles.axes1);
imshow(handles.originalImage);
handles.param1 = 50;
handles.param2 = 50;
set(handles.axes2, 'visible', 'off');
setAllParamInvisible(hObject, eventdata, handles)
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = teste_guide_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in imageDropdown.
function imageDropdown_Callback(hObject, eventdata, handles)
    str = get(hObject, 'String');
    val = get(hObject, 'Value');

    switch str{val}
     case 'peppers.png'
         handles.originalImage = imread('peppers.png');
     case 'eight.tif'
         handles.originalImage = imread('eight.tif');
     case 'ngc6543a.jpg'
         handles.originalImage = imread('ngc6543a.jpg');
     case 'street1.jpg'
         handles.originalImage = imread('street1.jpg');
     case 'street2.jpg'
         handles.originalImage = imread('street2.jpg');
     case 'landOcean.jpg'
         handles.originalImage = imread('landOcean.jpg');
     case 'cameraman.tif'
         handles.originalImage = imread('cameraman.tif');
     case 'circuit.tif'
         handles.originalImage = imread('circuit.tif');
    
    end
    handles.stackImage = {handles.originalImage};
    set([handles.axes2;handles.axes2.Children], 'visible', 'off');
    axes(handles.axes1);
    imshow(handles.originalImage);
    guidata(hObject, handles);

    
% --- Executes during object creation, after setting all properties.
function imageDropdown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imageDropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on key press with focus on Prewitt and none of its controls.
function Prewitt_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Prewitt (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in filtroDropdown.
function filtroDropdown_Callback(hObject, eventdata, handles)

    
    handles.currentFilterStr = get(hObject, 'String');
    handles.currentFilterVal = get(hObject, 'Value');
    guidata(hObject, handles);
    executeFilter(hObject, eventdata, handles)
    


function setAllParamInvisible(hObject, eventdata, handles)
         set(handles.edit2, 'visible', 'off');
         set(handles.text8, 'visible', 'off');
         set(handles.edit3, 'visible', 'off');
         set(handles.text9, 'visible', 'off');
         
function setParam1Visible(hObject, eventdata, handles)
         set(handles.edit2, 'visible', 'on');
         set(handles.text8, 'visible', 'on');
         set(handles.pushbutton8, 'visible', 'on');
         
function setParam2Visible(hObject, eventdata, handles)
         set(handles.edit3, 'visible', 'on');
         set(handles.text9, 'visible', 'on');
         set(handles.pushbutton8, 'visible', 'on');
    
function executeFilter(hObject, eventdata, handles)

    switch handles.currentFilterStr{handles.currentFilterVal}
     case 'Limiarização (Threshold)'
         setParam1Visible(hObject, eventdata, handles)  
         handles.stackImage(end+1) = bin(hObject, eventdata, handles)
     case 'Escala de Cinza'
         setAllParamInvisible(hObject, eventdata, handles)
         handles.stackImage(end+1) = toGrayScale(hObject, eventdata, handles)
     case 'Passa-Alta - Básico'
         setParam1Visible(hObject, eventdata, handles)
         handles.stackImage(end+1) = highPass(hObject, eventdata, handles)
     case 'Passa-Alta - Alto reforço'
         setParam1Visible(hObject, eventdata, handles)
         setParam2Visible(hObject, eventdata, handles)
         handles.stackImage(end+1) = highRein(hObject, eventdata, handles)
     case 'Passa-Baixa - Média (Básico)'
         setParam1Visible(hObject, eventdata, handles);
         handles.stackImage(end+1) = lowPass(hObject, eventdata, handles)
     case 'Passa-Baixa - Mediana'
         setAllParamInvisible(hObject, eventdata, handles)
         handles.stackImage(end+1) = lowPassMedian(hObject, eventdata, handles)
     case 'Roberts'
         setAllParamInvisible(hObject, eventdata, handles)
         handles.stackImage(end+1) = roberts(hObject, eventdata, handles)
     case 'Prewitt'
         setAllParamInvisible(hObject, eventdata, handles)
         handles.stackImage(end+1) = prewitts(hObject, eventdata, handles)
     case 'Sobel'
         setAllParamInvisible(hObject, eventdata, handles)
         handles.stackImage(end+1) = sobel(hObject, eventdata, handles)
     case 'Log'
         setParam1Visible(hObject, eventdata, handles)
         setParam2Visible(hObject, eventdata, handles) 
         handles.stackImage(end+1) = log(hObject, eventdata, handles)
     case 'Zerocross'
         setAllParamInvisible(hObject, eventdata, handles)
         handles.stackImage(end+1) = zerocross(hObject, eventdata, handles)
     case 'Canny'
         setAllParamInvisible(hObject, eventdata, handles)
         handles.stackImage(end+1) = canny(hObject, eventdata, handles)
     case 'Salt & Pepper'
         setParam1Visible(hObject, eventdata, handles)
         handles.stackImage(end+1) = saltPepper(hObject, eventdata, handles)
     case 'Watershed'
         handles.stackImage(end+1) = waterShed(hObject, eventdata, handles)
         setAllParamInvisible(hObject, eventdata, handles)
     case 'Histograma'
         histograma(hObject, eventdata, handles)
         setAllParamInvisible(hObject, eventdata, handles)
         return
     case 'Ajuste adaptativo de histograma'
         handles.stackImage(end+1) = histogramAdjust(hObject, eventdata, handles)
         setAllParamInvisible(hObject, eventdata, handles)
     case 'Contagem simples de objetos limiarizados com marcação na imagem'
         setParam1Visible(hObject, eventdata, handles)
         objectCounting(hObject, eventdata, handles)
         return
         
          
    end
    axes(handles.axes2);
    imshow(handles.stackImage{end})
    guidata(hObject, handles);
    

function pushbutton8_Callback(hObject, eventdata, handles)
    executeFilter(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function filtroDropdown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filtroDropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function stackImage = prewitts(hObject, eventdata, handles)
mask = fspecial('prewitt'); 
stackImageHorizontal = imfilter(handles.stackImage{end}, mask);
stackImageVertical = imfilter(handles.stackImage{end}, mask');
stackImage = {stackImageHorizontal + stackImageVertical + handles.originalImage};

function stackImage = sobel(hObject, eventdata, handles)
mask = fspecial('sobel'); 
stackImageHorizontal = imfilter(handles.stackImage{end}, mask);
stackImageVertical = imfilter(handles.stackImage{end}, mask');
stackImage = {stackImageHorizontal + stackImageVertical + handles.originalImage};

function stackImage = bin(hObject, eventdata, handles)
stackImage = {im2bw(handles.stackImage{end}, handles.param1/100)};

function stackImage = toGrayScale(hObject, eventdata, handles)
if(ndims(handles.stackImage{end}) > 2)
    stackImage = {rgb2gray(handles.stackImage{end})};
else
    stackImage = {handles.stackImage{end}};
end

function stackImage = highPass(hObject, eventdata, handles)
h = fspecial('unsharp', handles.param1/100)
stackImage = {imfilter(handles.stackImage{end}, h)};

function stackImage = lowPass(hObject, eventdata, handles)
h = fspecial('average', handles.param1)
stackImage = {imfilter(handles.stackImage{end}, h)};

function stackImage = highRein(hObject, eventdata, handles)
h = fspecial('unsharp', handles.param1/100)
hp = imfilter(handles.stackImage{end}, h);
stackImage = {(handles.param2 / 100 - 1) *  handles.originalImage + hp};

function stackImage = lowPassMedian(hObject, eventdata, handles)
imageGrey = toGrayScale(hObject, eventdata, handles)
stackImage = {imclearborder(medfilt2(imageGrey{end}))};

function stackImage = histograma(hObject, eventdata, handles)
axes(handles.axes2);
imageGrey = toGrayScale(hObject, eventdata, handles)
imhist(imageGrey{end})

function stackImage = roberts(hObject, eventdata, handles)
imageGrey = toGrayScale(hObject, eventdata, handles)
stackImage = {edge(imageGrey{end}, 'Roberts')};

function stackImage = canny(hObject, eventdata, handles)
imageGrey = toGrayScale(hObject, eventdata, handles)
stackImage = {edge(imageGrey{end}, 'Canny')};

function stackImage = log(hObject, eventdata, handles)
h = fspecial('log', handles.param1, handles.param2/100)
stackImage = {imfilter(handles.stackImage{end}, h)};

function stackImage = zerocross(hObject, eventdata, handles)
imageGrey = toGrayScale(hObject, eventdata, handles)
stackImage = {edge(imageGrey{end}, 'zerocross')};

function stackImage = saltPepper(hObject, eventdata, handles)
stackImage = {imnoise(handles.stackImage{end}, 'salt & pepper',  handles.param1/100)};

function stackImage = histogramAdjust(hObject, eventdata, handles)
imageGrey = toGrayScale(hObject, eventdata, handles);
stackImage = {adapthisteq(imageGrey{end})};

function objectCounting(hObject, eventdata, handles)
h = fspecial('average');
pb = imfilter(handles.stackImage{end}, h);
bw = ~im2bw(pb, handles.param1/100);
b = bwboundaries(bw);
axes(handles.axes2);
imshow(handles.stackImage{end})
hold on
for k=1:length(b)
    boundary = b{k};
    plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 1)
end
hold off


function stackImage = waterShed(hObject, eventdata, handles)
image = toGrayScale(hObject, eventdata, handles);
%segmentation
gmag = imgradient(image{end});
L = watershed(gmag);
Lrgb = label2rgb(L);
se = strel('disk',20);
Io = imopen(image{end},se);
Ie = imerode(image{end},se);
Iobr = imreconstruct(Ie,image{end});
Ioc = imclose(Io,se);
% reconstruction
Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
fgm = imregionalmax(Iobrcbr);
I2 = labeloverlay(image{end},fgm);
se2 = strel(ones(5,5));
fgm2 = imclose(fgm,se2);
fgm3 = imerode(fgm2,se2);
fgm4 = bwareaopen(fgm3,20);
I3 = labeloverlay(image{end},fgm4);
%binaraize
bw = imbinarize(Iobrcbr);
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
gmag2 = imimposemin(gmag, bgm | fgm4);
L = watershed(gmag2);
labels = imdilate(L==0,ones(3,3)) + 2*bgm + 3*fgm4;
I4 = labeloverlay(image{end},labels);
stackImage = {label2rgb(L,'jet','w','shuffle')};

% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
    switch eventdata.Key
        case 'f1'
            undo(hObject, eventdata, handles)
    end

function undo(hObject, eventdata, handles)
    if length(handles.stackImage) > 1
        handles.stackImage(end) = [];
        guidata(hObject, handles);
        axes(handles.axes2);
        imshow(handles.stackImage{end})
    end

% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
    get(hObject,'String')
    handles.param1 = str2double(get(hObject,'String'));
    guidata(hObject, handles);
    


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
    undo(hObject, eventdata, handles)



function edit3_Callback(hObject, eventdata, handles)
    get(hObject,'String')
    handles.param2 = str2double(get(hObject,'String'));
    guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
  [FileName,PathName]  = uigetfile("*");
  handles.originalImage = imread(fullfile(PathName, FileName));
  handles.stackImage = {handles.originalImage};
  set([handles.axes2;handles.axes2.Children], 'visible', 'off');
  axes(handles.axes1);
  imshow(handles.originalImage);
  guidata(hObject, handles);


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
setAllParamInvisible(hObject, eventdata, handles)
handles.stackImage = {handles.originalImage};
    set([handles.axes2;handles.axes2.Children], 'visible', 'off');
    axes(handles.axes1);
    imshow(handles.originalImage);
    guidata(hObject, handles);

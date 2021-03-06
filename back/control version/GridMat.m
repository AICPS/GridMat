function varargout = GridMat(varargin)
% GRIDMAT M-file for GridMat.fig
%      GRIDMAT, by itself, creates a new GRIDMAT or raises the existing
%      singleton*.
%
%      H = GRIDMAT returns the handle to a new GRIDMAT or the handle to
%      the existing singleton*.
%
%      GRIDMAT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRIDMAT.M with the given input arguments.
%
%      GRIDMAT('Property','Value',...) creates a new GRIDMAT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GridMat_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GridMat_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GridMat

% Last Modified by GUIDE v2.5 10-Jun-2013 17:38:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GridMat_OpeningFcn, ...
                   'gui_OutputFcn',  @GridMat_OutputFcn, ...
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


% --- Executes just before GridMat is made visible.
function GridMat_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GridMat (see VARARGIN)

% Choose default command line output for GridMat
handles.output = hObject;
if nargin == 3,
    initial_dir = pwd;
elseif nargin == 5
    initial_dir = varargin{1};
else
    errordlg({'Input argument must be a valid',...
        'folder'},'Input Argument Error!')
    return
end
cd(initial_dir);
set(handles.filename_edit,'String',initial_dir);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GridMat wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GridMat_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open_pushbutton.
function open_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to open_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename filepath] = uigetfile({'*.m'},'File Selector');
if (filename~=0)
    [path,name,ext] = fileparts(filename);
    str=get(handles.controller_popupmenu,'String');
    if(isempty(str))
        str={name};
    else
        str={str{:},name};
    end
    set(handles.controller_popupmenu,'String',str);
    set(handles.controller_popupmenu,'Value',size(str,2));
end



function time_edit_Callback(hObject, eventdata, handles)
% hObject    handle to time_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_edit as text
%        str2double(get(hObject,'String')) returns contents of time_edit as a double


% --- Executes during object creation, after setting all properties.
function time_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in debug_pushbutton.
function debug_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to debug_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%dos(['SET PATH=%%PATH%%;C:\Users\Ahourai\Documents\EVSE\EVSE-PROJECT\GridLAB-D\3.0\VS2005\x64\release;C:\Usersc\Ahourai\Documents\EVSE\EVSE-PROJECT\GridLAB-D\3.0\core\rt; &','gridlabd ',char(get(handles.filename_edit,'String')),' --server &']);
%j=batch(@core,1,{handles});
[path,name,ext] = fileparts(get(handles.filename_edit,'String'));
if(strcmp(ext,'.glm')==0 || isempty(name))
    return;
end
set(handles.debug_pushbutton,'Enable','off') 
set(handles.run_pushbutton,'Enable','off') 
set(handles.stop_pushbutton,'Enable','on') 
core(handles);
set(handles.debug_pushbutton,'Enable','on') 
set(handles.run_pushbutton,'Enable','on') 
set(handles.stop_pushbutton,'Enable','off') 


% --- Executes on button press in run_pushbutton.
function run_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to run_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stop_pushbutton.
function stop_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to stop_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sopen_pushbutton.
function sopen_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to sopen_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in snew_pushbutton.
function snew_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to snew_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sedit_pushbutton.
function sedit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to sedit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sparam_pushbotton.
function sparam_pushbotton_Callback(hObject, eventdata, handles)
% hObject    handle to sparam_pushbotton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in new_pushbutton.
function new_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to new_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edit();


% --- Executes on selection change in controller_popupmenu.
function controller_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to controller_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns controller_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from controller_popupmenu


% --- Executes during object creation, after setting all properties.
function controller_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to controller_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in edit_pushbutton.
function edit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(handles.controller_popupmenu,'Value');
str=get(handles.controller_popupmenu,'String');
edit([pwd,'\',char(str(val)),'.m']);



% --- Executes on button press in param_pushbutton.
function param_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to param_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=get(handles.filename_edit,'String');
parameter(filename);


% --- Executes on button press in gopen_pushbutton.
function gopen_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to gopen_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename filepath] = uigetfile({'*.glm'},'File Selector');
if (filename~=0)
    cd(filepath);
    set(handles.filename_edit,'String',[filepath,filename]);
end
% --- Executes on button press in gnew_pushbutton.
function gnew_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to gnew_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edit();



function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu5 as text
%        str2double(get(hObject,'String')) returns contents of popupmenu5 as a double


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gedit_pushbutton.
function gedit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to gedit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edit(get(handles.filename_edit,'String'));



function filename_edit_Callback(hObject, eventdata, handles)
% hObject    handle to filename_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename_edit as text
%        str2double(get(hObject,'String')) returns contents of filename_edit as a double


% --- Executes during object creation, after setting all properties.
function filename_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plotter_pushbutton.
function plotter_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to plotter_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[path,name,ext] = fileparts(get(handles.filename_edit,'String'));
plotter(path);

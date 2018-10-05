function varargout = parameter(varargin)
% PARAMETER M-file for parameter.fig
%      PARAMETER, by itself, creates a new PARAMETER or raises the existing
%      singleton*.
%
%      H = PARAMETER returns the handle to a new PARAMETER or the handle to
%      the existing singleton*.
%
%      PARAMETER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARAMETER.M with the given input arguments.
%
%      PARAMETER('Property','Value',...) creates a new PARAMETER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before parameter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to parameter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help parameter

% Last Modified by GUIDE v2.5 12-Jun-2013 15:28:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @parameter_OpeningFcn, ...
                   'gui_OutputFcn',  @parameter_OutputFcn, ...
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


% --- Executes just before parameter is made visible.
function parameter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to parameter (see VARARGIN)

% Choose default command line output for parameter
handles.output = hObject;
if nargin == 3,
    errordlg({'Input argument must be a valid',...
        'GLM file'},'Input Argument Error!')
elseif nargin < 5
    errordlg({'Input argument must be a valid',...
        'controller'},'Input Argument Error!')
elseif nargin == 5
    handles.glmfile = varargin{1};
    handles.contfile = varargin{2};
else
    errordlg({'Input argument must be a valid',...
        'file'},'Input Argument Error!')
    return
end
set(handles.parameter_uitable,'Data',cell(0,0));
% Update handles structure
guidata(hObject, handles);
updatetable(handles);
updateobject(handles);

% UIWAIT makes parameter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = parameter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in object_listbox.
function object_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to object_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns object_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from object_listbox
val=get(hObject,'Value');
object=handles.object(val);
set(handles.parameter_text,'String',[upper(object),' parameters:']);
updateparameter(handles,object);


% --- Executes during object creation, after setting all properties.
function object_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to object_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in parameter_listbox.
function parameter_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to parameter_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns parameter_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from parameter_listbox
% add_pushbutton_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function parameter_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parameter_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_pushbutton.
function add_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to add_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
names=get(handles.object_listbox,'String');
val=get(handles.object_listbox,'Value');
name=names(val);
object=handles.object(val);
params=get(handles.parameter_listbox,'String');
param=params(get(handles.parameter_listbox,'Value'));
s=size(get(handles.parameter_uitable,'Data'),1);
addtable(handles,name,param,strcat(object,'_',num2str(s)),'Input');

% --- Executes on button press in remove_pushbutton.
function remove_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to remove_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in remove_pushbutton.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to remove_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function addtable(handles,object,param,name,type)
data=get(handles.parameter_uitable,'Data');
data=cat(1,data,{[char(object),'/',char(param)],char(name),type});
set(handles.parameter_uitable,'Data',data);


function updatetable(handles)
data=readParam(handles.contfile,'ALL');
set(handles.parameter_uitable,'Data',data);



function updateobject(handles)
fid = fopen(handles.glmfile);
data={};
handles.object={};
tline = fgets(fid);
while ischar(tline)
    pos1=strfind(tline,'object ');
    if(~isempty(pos1))
        pos2=strfind(tline,'{');
        tline=tline(pos1+7:pos2-1);
        object=strtrim(tline);
    end
    pos1=strfind(tline,'name ');
    if(~isempty(pos1))
        pos2=strfind(tline,';');
        tline=tline(pos1+5:pos2-1);
        if(isempty(data))
            data={tline}; 
            handles.object={object};
        else
            data={data{:},strtrim(tline)};
            handles.object={handles.object{:},object};
        end
    end
    tline = fgets(fid);
end
fclose(fid);
set(handles.object_listbox,'String',data);
guidata(handles.figure1, handles);


function updateparameter(handles,object)
fid = fopen('parameter.data');
data={};
tline = fgets(fid);
while (ischar(tline) && isempty(strfind(tline,['class ',char(object)])))
    tline = fgets(fid);
end    
tline = fgets(fid);
while (ischar(tline) && isempty(strfind(tline,'class')))
    pos1=strfind(tline,'//');
    if(~isempty(pos1))
       tline=tline(1:pos1-1);
    end
    object=strtrim(tline);
    if(~isempty(object))
        if(isempty(data))
            data={object}; 
        else
            data={data{:},object};
        end
    end
    tline = fgets(fid);
end
fclose(fid);
set(handles.parameter_listbox,'String',data);
guidata(handles.figure1, handles);


% --- Executes on button press in psave_pushbutton.
function psave_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to psave_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=get(handles.parameter_uitable,'Data');
writeParam(handles.contfile,data);
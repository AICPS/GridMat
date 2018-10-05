function varargout = typehouse(varargin)
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

% Last Modified by GUIDE v2.5 14-Jun-2013 10:21:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @typehouse_OpeningFcn, ...
                   'gui_OutputFcn',  @typehouse_OutputFcn, ...
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
function typehouse_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to parameter (see VARARGIN)
if nargin == 4,
    errordlg('Select one item','Input Argument Error!')
elseif nargin == 5
    handles.selected_type = varargin{1};
    handles.filename = varargin{2};
end
% Choose default command line output for parameter
handles.output = hObject;
% if nargin == 3,
%     errordlg({'Input argument must be a valid',...
%         'GLM file'},'Input Argument Error!')
% elseif nargin < 5
%     errordlg({'Input argument must be a valid',...
%         'controller'},'Input Argument Error!')
% elseif nargin == 5
%     handles.glmfile = varargin{1};
%     handles.contfile = varargin{2};
% else
%     errordlg({'Input argument must be a valid',...
%         'file'},'Input Argument Error!')
%     return
% end
% Update handles structure
guidata(hObject, handles);
% updatetable(handles);
% updateobject(handles);

% UIWAIT makes parameter wait for user response (see UIRESUME)
% uiwait(handles.figure1);
hmodel=getappdata(0,'hModel');
data_type=getappdata(hmodel,'data_type');
disp(data_type{1:1});

% if(~iscell(data_type{2}))
%    data_type{2}={data_type{2}};
% end
%% data_type is not being used right now! - irvin 8/7/13
% selected type is value of file name, 1 for char and 0 for ''
if(handles.selected_type == 1)
    set(handles.parameter_uitable,'Data',cell(0,0));
    set(handles.object_listbox,'String','house');
elseif(~isempty(data_type))
    set(handles.object_listbox,'String',data_type{2});
    set(handles.parameter_uitable,'Data',data_type{3});
end


% --- Outputs from this function are returned to the command line.
function varargout = typehouse_OutputFcn(hObject, eventdata, handles) 
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
objects=get(hObject,'String');
object=objects(get(hObject,'Value'));
set(handles.parameter_text,'String',[upper(object),' parameters:']);
updateparameter(handles,object);
%set(handles.object_listbox,'String','house');
%object_listbox = getappdata(0, 'object_listbox');


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


% --- Executes on button press in addobject_pushbutton.
function addobject_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to addobject_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
names=get(handles.object_popupmenu,'String');
object=names(get(handles.object_popupmenu,'Value'));
objects=get(handles.object_listbox,'String');
objects=cat(1,objects,object);
set(handles.object_listbox,'String',objects);

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

function addtable(handles,object,param,name,typehouse)
data=get(handles.parameter_uitable,'Data');
% if(isempty(data))
%     data={[object,'/',param],name,typehouse};
% else
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
% irvin - i want to get data from parameter and aobject lists
object_list=get(handles.object_listbox,'String');
parameter=get(handles.parameter_uitable,'Data');
% i want to retrieve handle from root so i can store data_type in it
hmodel=getappdata(0,'hModel');
type_popupmenu_handles=getappdata(hmodel,'type_popupmenu');
types=(get(type_popupmenu_handles,'String'));
typesize=size(types,1);
new_type_name=['Type ',num2str(typesize)];
types=cat(1,types,new_type_name);
set(type_popupmenu_handles,'String',types);
if(~iscell(object_list))
    object_list={object_list};
end
% i want to read lines from the model.typehouse_popupmenu
% model is passed to us through hModel in root (0)
%8-14-2013

% 
% tline=fgetl(fid);
% while (~isempty(tline))
%     pos1=strfind(tline,'}');
%     type_counter=str2num(tline(pos1+1));
%     tline=fgetl(fid);
% end
% type_counter=str2num(type_counter+1)
% type_name='{type'+type_counter+'}';
temp_data=getappdata(hmodel,'data_type');
temp_data=cat(1,temp_data,{new_type_name,object_list,parameter});
setappdata(hmodel,'data_type',temp_data);


% --- Executes on selection change in object_popupmenu.
function object_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to object_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns object_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from object_popupmenu


% --- Executes during object creation, after setting all properties.
function object_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to object_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_pushbutton.
function add_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to add_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
objects=cellstr(get(handles.object_listbox,'String'));
val=get(handles.object_listbox,'Value');
object=objects(val);
params=get(handles.parameter_listbox,'String');
param=params(get(handles.parameter_listbox,'Value'));
s=size(get(handles.parameter_uitable,'Data'),1);
data=get(handles.parameter_uitable,'Data');
data=cat(1,data,{char(object),char(param),''});
set(handles.parameter_uitable,'Data',data);

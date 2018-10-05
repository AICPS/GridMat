function varargout = selector(varargin)
% SELECTOR MATLAB code for selector.fig
%      SELECTOR, by itself, creates a new SELECTOR or raises the existing
%      singleton*.
%
%      H = SELECTOR returns the handle to a new SELECTOR or the handle to
%      the existing singleton*.
%
%      SELECTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECTOR.M with the given input arguments.
%
%      SELECTOR('Property','Value',...) creates a new SELECTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before selector_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to selector_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help selector

% Last Modified by GUIDE v2.5 14-Jun-2013 11:34:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @selector_OpeningFcn, ...
                   'gui_OutputFcn',  @selector_OutputFcn, ...
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


% --- Executes just before selector is made visible.
function selector_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to selector (see VARARGIN)

% Choose default command line output for selector
handles.output = hObject;
if nargin == 3,
    errordlg({'Input argument must be a valid',...
        'IEEE file'},'Input Argument Error!')
elseif nargin < 5,
    errordlg({'Input argument must be a valid',...
        'house type'},'Input Argument Error!')
elseif nargin == 5
    handles.ieeefile = varargin{1};
    handles.types = varargin{2};
else
    errordlg({'Input argument must be a valid',...
        'file'},'Input Argument Error!')
    return
end
set(handles.transrate_edit,'Enable','off');
set(handles.select_uitable,'Data',cell(0,0));
[path,name,ext] = fileparts(handles.ieeefile);
axes(handles.jpg_axe);
imshow([path,'\',name,'.jpg']);
handles.data=readnodes(handles.ieeefile);
set(handles.node_popupmenu,'String',handles.data(:,1));
set(handles.phase_popupmenu,'String', handles.data{1,2});
temp=cell(size(handles.types,1),1);
temp(:)={''};
data=cat(2,handles.types,temp)
set(handles.type_uitable,'Data', data);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes selector wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = selector_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on selection change in node_popupmenu.
function node_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to node_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(handles.node_popupmenu,'Value');
set(handles.phase_popupmenu,'String',handles.data{val,2});
% Hints: contents = cellstr(get(hObject,'String')) returns node_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from node_popupmenu


% --- Executes during object creation, after setting all properties.
function node_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to node_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in phase_popupmenu.
function phase_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to phase_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns phase_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from phase_popupmenu


% --- Executes during object creation, after setting all properties.
function phase_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phase_popupmenu (see GCBO)
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
nodes=get(handles.node_popupmenu,'String');
phases=get(handles.phase_popupmenu,'String');
node=nodes(get(handles.node_popupmenu,'Value'));
phase=phases(get(handles.phase_popupmenu,'Value'));
data=get(handles.select_uitable,'Data');
num=str2num(get(handles.transrange_edit,'String'));
if(get(handles.transrand_checkbox,'Value')==1)
    transnum= randi([num]);
else
    transnum=num;
end
if(get(handles.defaultrate_checkbox,'Value')==1)
    transrate= transnum*5000;
else
    transrate=str2num(get(handles.transrate_edit,'String'));
end
types=get(handles.type_uitable,'Data');
data=cat(1,data,{node{:},phase{:},transnum,transrate,''});
set(handles.select_uitable,'Data',data);


% --- Executes during object creation, after setting all properties.
function jpg_axe_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jpg_axe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate jpg_axe
function [data]=readnodes(ieeefile)
fid = fopen(ieeefile);
data={};
node='';
object='';
tline = fgets(fid);
while ischar(tline)
    pos1=strfind(tline,'}');
    if(~isempty(pos1))
        object='';
    end
    pos1=strfind(tline,'object node');
    if(~isempty(pos1))
        object='node';
    end
    pos1=strfind(tline,'name node');
    if(~isempty(pos1) &&  ~isempty(object))
        pos2=strfind(tline,';');
        node=strtrim(tline(pos1+9:pos2-1));
        object='';
    end
    pos1=strfind(tline,'phases');
    if(~isempty(pos1) && ~isempty(node))
        pos2=strfind(tline,';');
        tline=strtrim(tline(pos1+7:pos2-1));
        phases={};
        for i=tline
            if(i~='N')
                phases=cat(1,phases,i);
            end
        end
        data=cat(1,data,{node,phases});
        node='';
    end
    tline = fgets(fid);
end
fclose(fid);


% --- Executes on button press in save_pushbutton.
function save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function transrange_edit_Callback(hObject, eventdata, handles)
% hObject    handle to transrange_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of transrange_edit as text
%        str2double(get(hObject,'String')) returns contents of transrange_edit as a double


% --- Executes during object creation, after setting all properties.
function transrange_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to transrange_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in transrand_checkbox.
function transrand_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to transrand_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of transrand_checkbox


% --- Executes on button press in defaultrate_checkbox.
function defaultrate_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to defaultrate_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.defaultrate_checkbox,'Value')==1)
    set(handles.transrate_edit,'Enable','off');
else
    set(handles.transrate_edit,'Enable','on');
end
    % Hint: get(hObject,'Value') returns toggle state of defaultrate_checkbox



function transrate_edit_Callback(hObject, eventdata, handles)
% hObject    handle to transrate_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of transrate_edit as text
%        str2double(get(hObject,'String')) returns contents of transrate_edit as a double


% --- Executes during object creation, after setting all properties.
function transrate_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to transrate_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uipanel4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when entered data in editable cell(s) in type_uitable.
function type_uitable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to type_uitable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in type_uitable.
function type_uitable_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to type_uitable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

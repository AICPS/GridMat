function varargout = plotter(varargin)
% PLOTTER_PANEL M-file for plotter_panel.fig
%      PLOTTER_PANEL, by itself, creates a new PLOTTER_PANEL or raises the existing
%      singleton*.
%
%      H = PLOTTER_PANEL returns the handle to a new PLOTTER_PANEL or the handle to
%      the existing singleton*.
%
%      PLOTTER_PANEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTTER_PANEL.M with the given input arguments.
%
%      PLOTTER_PANEL('Property','Value',...) creates a new PLOTTER_PANEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plotter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plotter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plotter_panel

% Last Modified by GUIDE v2.5 10-Jun-2013 20:03:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @plotter_OpeningFcn, ...
    'gui_OutputFcn',  @plotter_OutputFcn, ...
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


% --- Executes just before plotter_panel is made visible.
function plotter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plotter_panel (see VARARGIN)

% Choose default command line output for plotter_panel
handles.output = hObject;
% load_list('C:\Users\Fereidoun\Documents\MATLAB\simpleGUI\',handles);

if nargin == 3,
    initial_dir = pwd;
elseif nargin == 4
    initial_dir = varargin{1};
else
    errordlg({'Input argument must be a valid',...
        'folder'},'Input Argument Error!')
    return
end
% Populate the listbox
load_list(initial_dir,handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plotter_panel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plotter_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in filelist_listbox.
function filelist_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to filelist_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns filelist_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filelist_listbox

% If double click
if strcmp(get(handles.figure1,'SelectionType'),'open')
    index_selected = get(handles.filelist_listbox,'Value');
    file_list = get(handles.filelist_listbox,'String');
    file_path = get(handles.path_editbox,'String');
    % Item selected in list box
    filename = [file_path,'\\',file_list{index_selected}];
    [path,name,ext] = fileparts(filename);
    [ts,leg]=read_csv_file(filename);
    plot(ts);
    %     grid on;
    legend(leg,'Location','NorthWest');
    title(upper(strrep(name, '_', ' ')));
    ylabel('');
    xlabel([ts.TimeInfo.StartDate]);
    
end


% --- Executes during object creation, after setting all properties.
function filelist_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filelist_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function path_editbox_Callback(hObject, eventdata, handles)
% hObject    handle to path_editbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path_editbox as text
%        str2double(get(hObject,'String')) returns contents of path_editbox as a double
new_dir=get(handles.path_editbox,'String');
load_list(new_dir,handles);

% --- Executes during object creation, after setting all properties.
function path_editbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path_editbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function load_list(dir_path, handles)
% cd (dir_path)
dir_struct = dir([dir_path,'\*.csv']);
sorted_names = sortrows({dir_struct.name}');
handles.file_names = sorted_names;
guidata(handles.figure1,handles);
set(handles.filelist_listbox,'String',handles.file_names,...
    'Value',1);
set(handles.path_editbox,'String',dir_path);

function [ts,leg]=read_csv_file(fileToRead)
fid = fopen(fileToRead,'rt');
C = textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s','Delimiter',',','CollectOutput',1);
fclose(fid);
if(strcmp(C{1,1}(9,1),'# timestamp') || strcmp(C{1,1}(9,1),'# property.. timestamp'))
    HEADERLINES=9;
else
    HEADERLINES=8;
end
for e=3 : 10
    if strcmp(C{1,1}(HEADERLINES,e),'')==1
        break;
    end
end
correct = strrep(C{1,1}(HEADERLINES+1:end,2:e-1), 'd', 'i');
time_axe = datenum(C{1,1}(HEADERLINES+1:end,1),'yyyy-mm-dd HH:MM:SS');
measure_axe=abs(cellfun(@str2num,correct));

ts = timeseries(measure_axe,time_axe,'name', 'intersection1');
ts.Name = '';
ts.TimeInfo.Units = 'second';
ts.TimeInfo.StartDate = datestr(time_axe(1,1)); % Set start date.
ts.TimeInfo.Format = 'HH:MM';   % Set format for display on x-axis.
ts.Time=ts.Time-ts.Time(1);       % Express time relative to the start date.
leg=strrep(C{1,1}(HEADERLINES,2:e-1), '_', ' ');


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

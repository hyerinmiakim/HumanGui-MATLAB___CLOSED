function varargout = humangui(varargin)
% HUMANGUI MATLAB code for humangui.fig
%      HUMANGUI, by itself, creates a new HUMANGUI or raises the existing
%      singleton*.
%
%      H = HUMANGUI returns the handle to a new HUMANGUI or the handle to
%      the existing singleton*.
%
%      HUMANGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HUMANGUI.M with the given input arguments.
%
%      HUMANGUI('Property','Value',...) creates a new HUMANGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before humangui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to humangui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help humangui

% Last Modified by GUIDE v2.5 07-Jun-2015 14:28:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @humangui_OpeningFcn, ...
                   'gui_OutputFcn',  @humangui_OutputFcn, ...
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


% --- Executes just before humangui is made visible.
function humangui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to humangui (see VARARGIN)

% Choose default command line output for humangui
handles.output = hObject;
axes(handles.axes1);
[FileName, PathName] = uigetfile('person1_stading.bod','Select the body mesh file to open');
S = load(FileName, '-mat'); 
P = S.P; t = S.t; 
patch('Faces', t, 'Vertices', P, 'FaceColor', [0.9 0.7 0.6], 'EdgeColor', 'none');
axis 'equal'; axis 'tight'; set(gca, 'YDir','normal');
xlabel('x, m'); ylabel('y, m'); 
view(70, 25); grid on; axis off;
camlight right; 
camlight left;
lighting phong;
camlight('headlight');
camlight(180, 20);
handles.i1=1;
% Update handles structure
global i1;
global i2;
i2=camlight('headlight');
i1=0;
handles.timer   = timer('ExecutionMode', 'FixedRate', 'Period', 0.08, ...
    'TimerFcn', {@turn, hObject} );
start(handles.timer);
hold on;
handles.th = 0:0.01:2*pi;
handles.px = 0.03*cos(handles.th);
handles.pz = 0.03*sin(handles.th);
handles.py = 0.03*ones(1,size(handles.px,2));
% patch(handles.px,handles.py+1,handles.pz+1,'r','EdgeColor', 'none');


[s, Fs] = audioread('spring.mp3');
handles.M = audioplayer(s,Fs);
play(handles.M);
guidata(hObject, handles);

% UIWAIT makes humangui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = humangui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.

function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% v=get(hObject,'string');
% set(handles.text2,'string',v);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
% if (strcmp(get(hObject.String),'��')==1)
%    set(handles.text4.String,'��'); 
% end
v= get(hObject,'value');
s= get(hObject,'String');
set(handles.text4, 'String',s{v});
if (v==1)
    set(handles.text3,'String', '�˰���� ��Ī�� �����Ͻÿ�.')
end
if (v==2)
    stop(handles.timer);
    set(handles.axes1,'View',[180 20]);
    set(handles.text3,'String', '��� ô�ߵ����� ��κ��� ��ô�ߵ����� �־ �Ű���� ���߰� �Ǵ� ����̴�.');
    set(handles.togglebutton2,'String','play');
    set(handles.togglebutton2,'value',1);
    patch(handles.px-0.058,handles.py+0.5,handles.pz+1.88,'r','EdgeColor', 'none');
end
if (v==3)
    stop(handles.timer);
    set(handles.axes1,'View',[180 20]);
    set(handles.text3,'String', '������ ��ȯ��Ű�� �������� �Ǵ� ��ȯ���� ���߱������, �ֱ����� ����� �̿��� ��Ǯ�������ν� ������ �¸��� �����ϴ� ���������� �Ѵ�.');
    set(handles.togglebutton2,'String','play');
    set(handles.togglebutton2,'value',1);
    patch(handles.px-0.180,handles.py+0.5,handles.pz+1.5,'r','EdgeColor', 'none');
end
if (v==4)
    stop(handles.timer);
    set(handles.axes1,'View',[180 20]);
    set(handles.text3,'String', '���θ� �Ʒ� ��󺹺ο� ��ġ�� ���� ź��ȭ�����, �ƹ̳�� �� �ܹ��� ���,��Ÿ�� �� ������ ���, �ص� �ۿ� �� ��� �ۿ� ���� �ֿ� ����� ����Ѵ�.');
    set(handles.togglebutton2,'String','play');
    set(handles.togglebutton2,'value',1);
    patch(handles.px+0.015,handles.py+0.5,handles.pz+1.30,'r','EdgeColor', 'none');
end
if (v==5)
    stop(handles.timer);
    set(handles.axes1,'View',[180 20]);
    set(handles.text3,'String', '��ȭ���� �Ϻκ����� �ĵ��� ��â�ڸ� �̾��ִ� ���� �� �ָӴ��̴�.');
    set(handles.togglebutton2,'String','play');
    set(handles.togglebutton2,'value',1);
    patch(handles.px-0.156,handles.py+0.5,handles.pz+1.30,'r','EdgeColor', 'none');
end
if (v==6)
    stop(handles.timer);
    set(handles.axes1,'View',[180 20]);
    set(handles.text3,'String', '���� ���� ������ �ɷ����� ������ ���·� �������� ô�ߵ����� �輳����̴�.');
    set(handles.togglebutton2,'String','play');
    set(handles.togglebutton2,'value',1);
    patch(handles.px-0.058,handles.py+0.5,handles.pz+1.085,'r','EdgeColor', 'none');
end
if (v==7)
    stop(handles.timer);
    set(handles.axes1,'View',[180 20]);
    set(handles.text3,'String', 'ô�ߵ����� ��ȭ��� �� �ϳ��� ���� ������ �����ؼ� �׹����� �̾�����. ��ȭ���� �� ���� ����� ����ϰ� �ִ�.');
    set(handles.togglebutton2,'String','play');
    set(handles.togglebutton2,'value',1);
    patch(handles.px-0.058,handles.py+0.5,handles.pz+1.230,'r','EdgeColor', 'none');
end
if (v==8)
    stop(handles.timer);
    set(handles.axes1,'View',[180 20]);
    set(handles.text3,'String', '���� ���� ���̿� �ִ� ���� 6��7m�� �̸��� ��ȭ������ ��ȭ��� �ϸ鼭 ������� ��ȭ������ϴ� �߿��� �κ��̴�. ') ;
    set(handles.togglebutton2,'String','play');
    set(handles.togglebutton2,'value',1);
    patch(handles.px-0.058,handles.py+0.5,handles.pz+1.150,'r','EdgeColor', 'none');
end
if (v==9)
    stop(handles.timer);
    set(handles.axes1,'View',[180 20]);
    set(handles.text3,'String', '������ �Ϻη� ���� �������� ���忡 �̸��� ���� ����� �����̴�.');
    set(handles.togglebutton2,'String','play');
    set(handles.togglebutton2,'value',1);
    patch(handles.px-0.100,handles.py+0.5,handles.pz+1.265,'r','EdgeColor', 'none');
end

disp (s{v})

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% stop(handles.timer);
% delete(handles.timer);
%
% function timer_cb(obj,event,hfigure)
% handles=guidata(hfigure);
% handles.i=handles.i+1;
% h = camlight('headlight');
%     camlight(h,'headlight')
%     view(handles.i, 30);
%     pause(0.01);
%     guidata(hfigure,handles);
function figure1_CloseRequestFcn(hObject,eventdata,handles)
stop(handles.timer);
delete(handles.timer);
delete(hObject);


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
% Hint: get(hObject,'Value') returns toggle state of togglebutton2

if get(handles.togglebutton2,'Value') == 1
    stop(handles.timer);
    set(handles.axes1,'View',[180 20]);
    set( hObject, 'String', 'Play' );
else
    start(handles.timer);
    global i1;
    set(handles.axes1,'View',[i1 20]);
    set( hObject, 'String', 'Stop' );
end
guidata( hObject, handles );

function turn(obj,event,hfigure)
handles=guidata(hfigure);
global i1;
set(handles.axes1,'View',[i1 30]);
global i2;
i1=i1+5;
camlight(i2,'headlight');
 guidata( hfigure,handles);

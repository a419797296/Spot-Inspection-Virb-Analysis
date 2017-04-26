function varargout = virb_analysis(varargin)
% VIRB_ANALYSIS MATLAB code for virb_analysis.fig
%      VIRB_ANALYSIS, by itself, creates a new VIRB_ANALYSIS or raises the existing
%      singleton*.
%
%      H = VIRB_ANALYSIS returns the handle to a new VIRB_ANALYSIS or the handle to
%      the existing singleton*.
%
%      VIRB_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIRB_ANALYSIS.M with the given input arguments.
%
%      VIRB_ANALYSIS('Property','Value',...) creates a new VIRB_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before virb_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to virb_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help virb_analysis

% Last Modified by GUIDE v2.5 24-Apr-2017 09:44:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @virb_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @virb_analysis_OutputFcn, ...
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


% --- Executes just before virb_analysis is made visible.
function virb_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to virb_analysis (see VARARGIN)

% Choose default command line output for virb_analysis
handles.output = hObject;
if ~exist('Data','dir') 
    mkdir('Data')         % 若不存在，在当前目录中产生一个子目录‘Figure’
end 
set(handles.off_line,'value',1)
    set(handles.ch1_norm,'string','0')
    set(handles.ch2_norm,'string','0')

    dir_info=dir('./measureData');   % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
    % dirs=dir(fulpath);   % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
    dircell=struct2cell(dir_info)' ;    % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
    % dircell=struct2cell(dirs)' ;    % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
    filenames=dircell(3:end,1) ;  % 第一列是文件名
    set(handles.file_list,'string',filenames);%将辊号名称写入对应辊号listbox中，并将该辊号的路径存到listbox的‘userdata’属性中
    set(handles.file_list,'value',1);%默认选中辊号文件中的第一个
    if ~isempty(filenames)
        filename=filenames{1};
        filepath=fullfile('./measureData',filename);
        data=load(filepath);
        a_data=data(:,2)';
        Fs=500;
        color='b';
        virb_disp(hObject, eventdata, handles,a_data,Fs,color);
    end

    dir_info=dir('./Data');   % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
    % dirs=dir(fulpath);   % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
    dircell=struct2cell(dir_info)' ;    % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
    % dircell=struct2cell(dirs)' ;    % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
    filenames=dircell(3:end,1) ;  % 第一列是文件名
    set(handles.file_list_txt,'string',filenames);%将辊号名称写入对应辊号listbox中，并将该辊号的路径存到listbox的‘userdata’属性中
    set(handles.file_list_txt,'value',1);%默认选中辊号文件中的第一个
%     if ~isempty(filenames)
%         filename=filenames{1};
%         filepath=fullfile('./measureData',filename);
%         data=load(filepath);
%         a_data=data(:,2)';
%         Fs=500;
%         color='b';
%         virb_disp(hObject, eventdata, handles,a_data,Fs,color);
%     end

%------------------------初始化坐标轴
axes(handles.a_t)
title('Signal of Acceleration')
xlabel('t (seconds)')
ylabel('a(t) m/s^2')
hold on
grid
axes(handles.a_f)
title('Single-Sided Amplitude Spectrum of a(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
hold on
grid
axes(handles.v_t)
title('Signal of Velocity')
xlabel('t (second)')
ylabel('v(t) mm/s')
hold on
grid
axes(handles.v_f)
title('Single-Sided Amplitude Spectrum of v(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
hold on
grid
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes virb_analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = virb_analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in file_list.
function file_list_Callback(hObject, eventdata, handles)
% hObject    handle to file_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns file_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from file_list

    delete(findobj(handles.a_t,'type','Line'))
    delete(findobj(handles.a_f,'type','Line'))
    delete(findobj(handles.v_t,'type','Line'))
    delete(findobj(handles.v_f,'type','Line'))
    
value=get(handles.off_line,'value')
if value==1
    filenames=get(handles.file_list,'string');  %将辊号名称写入对应辊号listbox中，并将该辊号的路径存到listbox的‘userdata’属性中
    value=get(handles.file_list,'value');   %默认选中辊号文件中的第一个
    filename=filenames{value};
    filepath=fullfile('./measureData',filename);
    data=load(filepath);
    a_data=data(:,2)';
    Fs=500;
    color='b';
    virb_disp(hObject, eventdata, handles,a_data,Fs,color);
end

% --- Executes during object creation, after setting all properties.
function file_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function ch1_norm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch1_norm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value=get(handles.off_line,'value')
if value==1
    msgbox('Only can use this button in online mode')
    return
end
% 构造客户端tcpip对象
global tcpipClient

    delete(findobj(handles.a_t,'type','Line'))
    delete(findobj(handles.a_f,'type','Line'))
    delete(findobj(handles.v_t,'type','Line'))
    delete(findobj(handles.v_f,'type','Line'))
freq=get(handles.freq,'string');
Fs = str2double(freq);            % Sampling frequency
set(handles.upfreq,'string',num2str(Fs/2-1))
time=get(handles.time,'string');
channel=get(handles.channel,'string');
Length=Fs *str2double(time);
now=fix(clock);
filename=sprintf('%d_%02d%02d%02d.txt',Fs,now(4),now(5),now(6));
set(handles.filename,'string',filename)
set(handles.start,'UserData',1);
guidata(hObject, handles);
% 发送指令
instruction = ['{"jsonType":3,"freq":',freq,',"userName":"15055305685","productMac":"00:CA:01:0F:00:01","sampleNum":',num2str(Length),',"fileName":"blue","channelList":"',channel,'"}']
% 等待接收命令
fwrite(tcpipClient,instruction,'int8');
disp('Instruction sending succeeds.');
numSent = get(tcpipClient,'valuesSent');
disp(strcat('Bytes of instruction is :',num2str(numSent)));

if isempty(strfind(channel,'0'))
    set(handles.ch1_norm,'string','0')
end
if isempty(strfind(channel,'1'))
    set(handles.ch2_norm,'string','0')
end
if isempty(strfind(channel,'2'))
    set(handles.ch3_norm,'string','0')
end
% --- Executes on button press in off_line.
function off_line_Callback(hObject, eventdata, handles)
% hObject    handle to off_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(handles.off_line,'value')
% Hint: get(hObject,'Value') returns toggle state of off_line


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(handles.off_line,'value')
global tcpipClient
if value==0
    delete(findobj(handles.a_t,'type','Line'))
    delete(findobj(handles.a_f,'type','Line'))
    delete(findobj(handles.v_t,'type','Line'))
    delete(findobj(handles.v_f,'type','Line'))
    

    N = 2048;
    % tcpipClient = tcpip('127.0.0.1',6000,...
    %     'NetworkRole','Client');%设置对象属性,A端的IP为192.168.123.30
    tcpipClient = tcpip('192.168.1.251',3333,...
        'NetworkRole','Client');%设置对象属性,A端的IP为192.168.123.30
    set(tcpipClient,'OutputBufferSize',8*N); %设置缓存长度
    set(tcpipClient,'InputBufferSize',1024); %设置缓存长度
    set(tcpipClient,'Timeout',60); %设置连接时间为1分钟

    %打开连接对象
    fopen(tcpipClient);
    if strcmp(tcpipClient.Status,'open')
        msgbox('have connect to the control box')
    else
        msgbox('have not connect to the control box')
    end
    dec2int = @(x, bits) mod(x + 2^(bits-1), 2^bits) - 2^(bits-1);
    color='rgbk';
    h_line=zeros(4,4);
    L = 4096;             % Length of signal
    cmd=[];
    x=zeros(4,L);
    recv_num=zeros(1,4);

    % x=zeros(4,2048);
    while(get(handles.off_line,'value')==0)
    %    等待接收数据
        while(strcmp(tcpipClient.Status,'open'))
%     while(1)
%     %    等待接收数据
%         while(1)
            nBytes = get(tcpipClient,'BytesAvailable');
            if nBytes > 0
                break;
            end
             pause(0.001);
        end
        if nBytes==0
%             pause(0.01);
            continue;
        end
        % 接收数据
        recvRaw = fread(tcpipClient,nBytes,'int8') ;
        if get(handles.start,'UserData')==1    %reload
            cmd=[];
            set(handles.start,'UserData',0)
            recv_num=zeros(1,4);
            guidata(hObject, handles);
        end
        cmd = [cmd recvRaw'];
        idx=find(cmd==0);
        while ~isempty(idx)
            json_str=cmd(1:idx(1)-1);
            cmd=cmd(idx(1)+1:end);

            if ~isempty(strfind(char(json_str),'channel_info'))
                result=loadjson(char(json_str));
    %             result=loadjson('test_json.txt')
                channel_list=result.channelList;
                num=result.channel_info.num;
                data=result.channel_info.data;
                cur_pkg=result.channel_info.cur_package;
                total_pkg=result.channel_info.total_package;
                hex=str2hex(data);
                data_length=size(hex,2)/2;
                ad_value=zeros(1,data_length);

                filename=get(handles.filename,'string');
                fid=fopen(fullfile('Data',filename),'at');
                for j=1:data_length
                    ad_value(j)=hex(2*j-1)*256+hex(2*j);
                    ad_value(j)=dec2int(ad_value(j),16);
                    fprintf(fid,'%s\n',num2str(ad_value(j)));
                end
                fclose(fid);
                if recv_num(num+1)==0
                    x(num+1,1:data_length)=ad_value;   
                else
                    x(num+1,1:recv_num(num+1)+data_length)=[x(num+1,1:recv_num(num+1)) ad_value];
                end
                recv_num(num+1)=recv_num(num+1)+data_length;

    %            /************ run in shift mode when this code is enabled*************/

                if size(x,2)> L
                    x(num+1,1:L)=x(num+1,end-L+1:end);
                    x(:,L+1:end)=[];
                    recv_num(num+1)=L;
                end
    %             
    %            /************ run in shift mode when this code is enabled*************/        

                for i=1:4
                    if ishandle(h_line(num+1,i))&&h_line(num+1,i)~=0
                        delete(h_line(num+1,i))
                    end
                end
                a_data=x(num+1,1:recv_num(num+1));
                freq=get(handles.freq,'string');
                Fs = str2double(freq);            % Sampling frequency
                 h_line(num+1,:)=virb_disp(hObject, eventdata, handles,a_data,Fs,color(num+1));
                pause(0.001);

            end     
            idx=find(cmd==0);
        end

    end

else
    delete(findobj(handles.a_t,'type','Line'))
    delete(findobj(handles.a_f,'type','Line'))
    delete(findobj(handles.v_t,'type','Line'))
    delete(findobj(handles.v_f,'type','Line'))
    set(handles.ch1_norm,'string','0')
    set(handles.ch2_norm,'string','0')
    
    % 关闭和删除连接对象
    if strcmp(tcpipClient.Status,'open')
        disp 'closing the socket';  
        fclose(tcpipClient);     
    end

%     filenames=get(handles.file_list,'string');  %将辊号名称写入对应辊号listbox中，并将该辊号的路径存到listbox的‘userdata’属性中
%     filename=filenames{1};
%     filepath=fullfile('./measureData',filename);
%     data=load(filepath);
%     a_data=data(:,2)';
%     Fs=500;
%     color='b';
%     virb_disp(hObject, eventdata, handles,a_data,Fs,color);
%     
    dir_info=dir('./measureData');   % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
    % dirs=dir(fulpath);   % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
    dircell=struct2cell(dir_info)' ;    % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
    % dircell=struct2cell(dirs)' ;    % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
    filenames=dircell(3:end,1) ;  % 第一列是文件名
    set(handles.file_list,'string',filenames);%将辊号名称写入对应辊号listbox中，并将该辊号的路径存到listbox的‘userdata’属性中
    set(handles.file_list,'value',1);%默认选中辊号文件中的第一个
    if ~isempty(filenames)
        filename=filenames{1};
        filepath=fullfile('./measureData',filename);
        data=load(filepath);
        a_data=data(:,2)';
        Fs=500;
        color='b';
        virb_disp(hObject, eventdata, handles,a_data,Fs,color);
    end

    dir_info=dir('./Data');   % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
    % dirs=dir(fulpath);   % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
    dircell=struct2cell(dir_info)' ;    % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
    % dircell=struct2cell(dirs)' ;    % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
    filenames=dircell(3:end,1) ;  % 第一列是文件名
    set(handles.file_list_txt,'string',filenames);%将辊号名称写入对应辊号listbox中，并将该辊号的路径存到listbox的‘userdata’属性中
    set(handles.file_list_txt,'value',1);%默认选中辊号文件中的第一个
    
    
end



function channel_Callback(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of channel as text
%        str2double(get(hObject,'String')) returns contents of channel as a double


% --- Executes during object creation, after setting all properties.
function channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filename_Callback(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename as text
%        str2double(get(hObject,'String')) returns contents of filename as a double


% --- Executes during object creation, after setting all properties.
function filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in file_list_txt.
function file_list_txt_Callback(hObject, eventdata, handles)
% hObject    handle to file_list_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns file_list_txt contents as cell array
%        contents{get(hObject,'Value')} returns selected item from file_list_txt
  delete(findobj(handles.a_t,'type','Line'))
    delete(findobj(handles.a_f,'type','Line'))
    delete(findobj(handles.v_t,'type','Line'))
    delete(findobj(handles.v_f,'type','Line'))
    
value=get(handles.off_line,'value')
if value==1
    filenames=get(handles.file_list_txt,'string');  %将辊号名称写入对应辊号listbox中，并将该辊号的路径存到listbox的‘userdata’属性中
    value=get(handles.file_list_txt,'value');   %默认选中辊号文件中的第一个
    filename=filenames{value};
    filepath=fullfile('./Data',filename);
    data=load(filepath);
    a_data=data(:,1)';
    idx=strfind(filename,'_');
    Fs=str2double(filename(1:idx-1));
    color='b';
    virb_disp(hObject, eventdata, handles,a_data,Fs,color);
end




% --- Executes during object creation, after setting all properties.
function file_list_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_list_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upfreq_Callback(hObject, eventdata, handles)
% hObject    handle to upfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upfreq as text
%        str2double(get(hObject,'String')) returns contents of upfreq as a double


% --- Executes during object creation, after setting all properties.
function upfreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowfreq_Callback(hObject, eventdata, handles)
% hObject    handle to lowfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowfreq as text
%        str2double(get(hObject,'String')) returns contents of lowfreq as a double


% --- Executes during object creation, after setting all properties.
function lowfreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

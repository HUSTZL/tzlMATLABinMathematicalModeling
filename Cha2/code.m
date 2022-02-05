%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: C:\Users\hp\Desktop\MATLAB数学建模方法与实践（第3版）程序及数据\程序_MATLAB数学建模方法与实践_卓金武等\程序_MATLAB数学建模方法与实践_卓金武等\Cha2\sz000004.xls
%    工作表: Sheet1
%
% 由 MATLAB 于 2022-02-04 10:10:29 自动生成

%% 设置导入选项并导入数据
opts = spreadsheetImportOptions("NumVariables", 8);

% 指定工作表和范围
opts.Sheet = "Sheet1";
opts.DataRange = "A2:H99";

% 指定列名称和类型
opts.VariableNames = ["Date", "DateNum", "Popen", "Phigh", "Plow", "Pclose", "Volum", "Turn"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double"];

% 导入数据
tbl = readtable("C:\Users\hp\Desktop\MATLAB数学建模方法与实践（第3版）程序及数据\程序_MATLAB数学建模方法与实践_卓金武等\程序_MATLAB数学建模方法与实践_卓金武等\Cha2\sz000004.xls", opts, "UseExcel", false);

%% 转换为输出类型
Date = tbl.Date;
DateNum = tbl.DateNum;
Popen = tbl.Popen;
Phigh = tbl.Phigh;
Plow = tbl.Plow;
Pclose = tbl.Pclose;
Volum = tbl.Volum;
Turn = tbl.Turn;

%% 清除临时变量
clear opts tbl

figure
plot(DateNum, Pclose, 'k')
datetick('x', 'mm')
xlabel('Date')
ylabel('Money')
figure
bar(Pclose)

p = polyfit(DateNum, Pclose, 1);
P1 = polyval(p, DateNum)
figure
plot(DateNum, P1, DateNum, Pclose, '*g')
value = p(1)

MaxDD = maxdrawdown(Pclose)
risk = MaxDD
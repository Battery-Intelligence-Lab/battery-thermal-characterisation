function Batterymodel(kx,ky,kz,ha,ts,xhot,yhot)
%
% Battery thermal model with COMSOL Multiphysics
%
% Model exported on Dec 29 2020, 22:23 by COMSOL 5.4.0.246.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('D:\OneDrive - Nexus365\COMSOL\Li-ion\Thermal characterization');

model.label('Batterymodel.mph');

model.param.set('L', '190 [mm]', 'Cell length');
model.param.set('W', '150 [mm]', 'Cell width');
model.param.set('d', '7.2 [mm]', 'Cell thickness');
model.param.set('D', '24 [mm]', 'Heater diameter');
model.param.set('H', '0.2 [mm]', 'Heater thickness');
model.param.set('Th', '50 [degC]', 'Heater temperature');
model.param.set('T0', '22 [degC]', 'Ambient temperature');
model.param.set('xhot', [num2str(xhot) '[mm]'], 'Heater x');
model.param.set('yhot', [num2str(yhot) '[mm]'], 'Heater y');
model.param.set('rho', '2183 [kg/m^3]', 'Density');
model.param.set('cp', '1083 [J/kg/K]', 'Specific heat');
model.param.set('ha', [num2str(ha) '[W/(m^2*K)]'], 'Convective heat transfer coefficient');
model.param.set('kh', '0.1808 [W/(m*K)]', 'Heater conductivity');
model.param.set('kx', [num2str(kx) '[W/m/K]'], 'x-thermal conductivity');
model.param.set('ky', [num2str(ky) '[W/m/K]'], 'y-thermal conductivity');
model.param.set('kz', [num2str(kz) '[W/m/K]'], 'z-thermal conductivity');
model.param.set('ts', [num2str(ts) '[s]'], 'Simulation time');
model.param.set('Ltab', '50 [mm]', 'Tab length');
model.param.set('Wtab', '48 [mm]', 'Tab width');
model.param.set('Itab', '10 [mm]', 'Tab distance');
model.param.set('Htab', '0.4 [mm]', 'Tab thickness');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.result.table.create('evl3', 'Table');
model.result.table.create('evl2', 'Table');
model.result.table.create('tbl1', 'Table');

model.func.create('rect1', 'Rectangle');
model.func.create('int1', 'Interpolation');
model.func.create('int4', 'Interpolation');
model.func.create('int2', 'Interpolation');
model.func.create('int3', 'Interpolation');
model.func('rect1').set('lower', 0);
model.func('rect1').set('upper', 1);
model.func('rect1').set('smooth', 0);
model.func('int1').label('Ambient temperature');
model.func('int1').set('funcs', {'Tamb' '1'});
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'C:\Users\Jie\Desktop\Cell optimization\Ta.txt');
model.func('int1').set('argunit', 's');
model.func('int1').set('fununit', 'degC');
model.func('int4').label('Heater temperature ');
model.func('int4').set('funcs', {'Theat' '1'});
model.func('int4').set('source', 'file');
model.func('int4').set('filename', 'C:\Users\Jie\Desktop\Cell optimization\Th.txt');
model.func('int4').set('argunit', 's');
model.func('int4').set('fununit', 'degC');
model.func('int2').label('Hot spot');
model.func('int2').set('funcs', {'Thot' '1'});
model.func('int2').set('source', 'file');
model.func('int2').set('filename', 'C:\Users\Jie\Desktop\Cell optimization\Thot.txt');
model.func('int2').set('argunit', 's');
model.func('int2').set('fununit', 'degC');
model.func('int3').label('Average');
model.func('int3').set('funcs', {'Tave' '1'});
model.func('int3').set('source', 'file');
model.func('int3').set('filename', 'C:\Users\Jie\Desktop\Cell optimization\Tave.txt');

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').lengthUnit('mm');
model.component('comp1').geom('geom1').create('blk1', 'Block');
model.component('comp1').geom('geom1').feature('blk1').set('size', {'d' 'L' 'W'});
model.component('comp1').geom('geom1').create('wp1', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp1').set('quickplane', 'yz');
model.component('comp1').geom('geom1').feature('wp1').set('unite', true);
model.component('comp1').geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('c1').set('pos', {'xhot' 'yhot'});
model.component('comp1').geom('geom1').feature('wp1').geom.feature('c1').set('r', 'D/2');
model.component('comp1').geom('geom1').create('cyl1', 'Cylinder');
model.component('comp1').geom('geom1').feature('cyl1').set('pos', {'-H' 'xhot' 'yhot'});
model.component('comp1').geom('geom1').feature('cyl1').set('axis', [1 0 0]);
model.component('comp1').geom('geom1').feature('cyl1').set('r', 'D/2');
model.component('comp1').geom('geom1').feature('cyl1').set('h', 'H');
model.component('comp1').geom('geom1').create('wp2', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp2').set('quickplane', 'zx');
model.component('comp1').geom('geom1').feature('wp2').set('quicky', 'L');
model.component('comp1').geom('geom1').feature('wp2').set('unite', true);
model.component('comp1').geom('geom1').feature('wp2').geom.create('r1', 'Rectangle');
model.component('comp1').geom('geom1').feature('wp2').geom.feature('r1').set('pos', {'Itab' 'd/2-Htab/2'});
model.component('comp1').geom('geom1').feature('wp2').geom.feature('r1').set('size', {'Wtab' 'Htab'});
model.component('comp1').geom('geom1').feature('wp2').geom.create('r2', 'Rectangle');
model.component('comp1').geom('geom1').feature('wp2').geom.feature('r2').set('pos', {'W-Wtab-Itab' 'd/2-Htab/2'});
model.component('comp1').geom('geom1').feature('wp2').geom.feature('r2').set('size', {'Wtab' 'Htab'});
model.component('comp1').geom('geom1').create('ext1', 'Extrude');
model.component('comp1').geom('geom1').feature('ext1').setIndex('distance', 'Ltab', 0);
model.component('comp1').geom('geom1').feature('ext1').selection('input').set({'wp2'});
model.component('comp1').geom('geom1').run;
model.component('comp1').geom('geom1').run('fin');

model.component('comp1').view('view2').tag('view4');
model.component('comp1').view('view3').tag('view8');
model.view.create('view2', 2);
model.view.create('view3', 2);
model.view.create('view5', 2);
model.view.create('view6', 2);
model.view.create('view7', 2);

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material.create('mat3', 'Common');
model.component('comp1').material.create('mat4', 'Common');
model.component('comp1').material('mat1').selection.set([2]);
model.component('comp1').material('mat2').selection.set([1]);
model.component('comp1').material('mat3').selection.set([3]);
model.component('comp1').material('mat3').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.component('comp1').material('mat3').propertyGroup.create('Murnaghan', 'Murnaghan');
model.component('comp1').material('mat3').propertyGroup.create('Lame', ['Lam' native2unicode(hex2dec({'00' 'e9'}), 'unicode') ' parameters']);
model.component('comp1').material('mat4').selection.set([4]);
model.component('comp1').material('mat4').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.component('comp1').material('mat4').propertyGroup.create('linzRes', 'Linearized resistivity');

model.component('comp1').common.create('amth_ht', 'AmbientThermalProperties');

model.component('comp1').physics.create('ht', 'HeatTransfer', 'geom1');
model.component('comp1').physics('ht').create('temp1', 'TemperatureBoundary', 2);
model.component('comp1').physics('ht').feature('temp1').selection.set([1]);
model.component('comp1').physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.component('comp1').physics('ht').feature('hf1').selection.set([7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24]);

model.component('comp1').mesh('mesh1').create('ftet1', 'FreeTet');
model.component('comp1').mesh('mesh1').create('ftet2', 'FreeTet');
model.component('comp1').mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.component('comp1').mesh('mesh1').feature('ftet1').selection.set([2]);
model.component('comp1').mesh('mesh1').feature('ftet2').selection.geom('geom1', 3);
model.component('comp1').mesh('mesh1').feature('ftet2').selection.set([1 3 4]);
model.component('comp1').mesh('mesh1').feature('ftet2').create('size1', 'Size');

model.result.table('evl3').label('Evaluation 3D');
model.result.table('evl3').comments('Interactive 3D values');
model.result.table('evl2').label('Evaluation 2D');
model.result.table('evl2').comments('Interactive 2D values');
model.result.table('tbl1').comments('Average temperature (T)');

model.component('comp1').view('view1').set('showgrid', false);
model.view('view2').axis.set('xmin', -1.8940093517303467);
model.view('view2').axis.set('xmax', 1.8940093517303467);
model.view('view3').axis.set('xmin', -14.656166076660156);
model.view('view3').axis.set('xmax', 24.8750057220459);
model.view('view3').axis.set('ymin', 56.27566146850586);
model.view('view3').axis.set('ymax', 93.26712036132812);
model.component('comp1').view('view4').label('View 4');
model.component('comp1').view('view4').axis.set('xmin', -57.00311279296875);
model.component('comp1').view('view4').axis.set('xmax', 247.0031280517578);
model.component('comp1').view('view4').axis.set('ymin', -45.156494140625);
model.component('comp1').view('view4').axis.set('ymax', 195.156494140625);
model.view('view5').axis.set('xmin', -43.71104049682617);
model.view('view5').axis.set('xmax', 260.2193908691406);
model.view('view5').axis.set('ymin', -30.075218200683594);
model.view('view5').axis.set('ymax', 195.8190155029297);
model.view('view6').axis.set('xmin', -1.412500023841858);
model.view('view6').axis.set('xmax', 1.412500023841858);
model.view('view7').axis.set('xmin', -93.23504638671875);
model.view('view7').axis.set('xmax', -56.764957427978516);
model.view('view7').axis.set('ymin', 86.25);
model.view('view7').axis.set('ymax', 113.75);
model.component('comp1').view('view8').label('View 8');
model.component('comp1').view('view8').axis.set('xmin', -4.709434509277344);
model.component('comp1').view('view8').axis.set('xmax', 161.65625);
model.component('comp1').view('view8').axis.set('ymin', -45.90714645385742);
model.component('comp1').view('view8').axis.set('ymax', 85.60276794433594);

model.component('comp1').material('mat1').propertyGroup('def').set('density', '3100');
model.component('comp1').material('mat1').propertyGroup('def').set('heatcapacity', '841');
model.component('comp1').material('mat1').propertyGroup('def').set('thermalconductivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat2').propertyGroup('def').set('density', '1500');
model.component('comp1').material('mat2').propertyGroup('def').set('heatcapacity', '1100');
model.component('comp1').material('mat2').propertyGroup('def').set('thermalconductivity', {'kh' '0' '0' '0' 'kh' '0' '0' '0' 'kh'});
model.component('comp1').material('mat3').label('Aluminum');
model.component('comp1').material('mat3').set('family', 'aluminum');
model.component('comp1').material('mat3').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat3').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.component('comp1').material('mat3').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.component('comp1').material('mat3').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.component('comp1').material('mat3').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.component('comp1').material('mat3').propertyGroup('def').set('density', '2700[kg/m^3]');
model.component('comp1').material('mat3').propertyGroup('Enu').set('youngsmodulus', '70e9[Pa]');
model.component('comp1').material('mat3').propertyGroup('Enu').set('poissonsratio', '0.33');
model.component('comp1').material('mat3').propertyGroup('Murnaghan').set('l', '');
model.component('comp1').material('mat3').propertyGroup('Murnaghan').set('m', '');
model.component('comp1').material('mat3').propertyGroup('Murnaghan').set('n', '');
model.component('comp1').material('mat3').propertyGroup('Murnaghan').set('l', '');
model.component('comp1').material('mat3').propertyGroup('Murnaghan').set('m', '');
model.component('comp1').material('mat3').propertyGroup('Murnaghan').set('n', '');
model.component('comp1').material('mat3').propertyGroup('Murnaghan').set('l', '-2.5e11[Pa]');
model.component('comp1').material('mat3').propertyGroup('Murnaghan').set('m', '-3.3e11[Pa]');
model.component('comp1').material('mat3').propertyGroup('Murnaghan').set('n', '-3.5e11[Pa]');
model.component('comp1').material('mat3').propertyGroup('Lame').set('lambLame', '');
model.component('comp1').material('mat3').propertyGroup('Lame').set('muLame', '');
model.component('comp1').material('mat3').propertyGroup('Lame').set('lambLame', '');
model.component('comp1').material('mat3').propertyGroup('Lame').set('muLame', '');
model.component('comp1').material('mat3').propertyGroup('Lame').set('lambLame', '5.1e10[Pa]');
model.component('comp1').material('mat3').propertyGroup('Lame').set('muLame', '2.6e10[Pa]');
model.component('comp1').material('mat4').label('Copper');
model.component('comp1').material('mat4').set('family', 'copper');
model.component('comp1').material('mat4').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat4').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.component('comp1').material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.component('comp1').material('mat4').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.component('comp1').material('mat4').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat4').propertyGroup('def').set('density', '8960[kg/m^3]');
model.component('comp1').material('mat4').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.component('comp1').material('mat4').propertyGroup('Enu').set('youngsmodulus', '110e9[Pa]');
model.component('comp1').material('mat4').propertyGroup('Enu').set('poissonsratio', '0.35');
model.component('comp1').material('mat4').propertyGroup('linzRes').set('rho0', '');
model.component('comp1').material('mat4').propertyGroup('linzRes').set('alpha', '');
model.component('comp1').material('mat4').propertyGroup('linzRes').set('Tref', '');
model.component('comp1').material('mat4').propertyGroup('linzRes').set('rho0', '');
model.component('comp1').material('mat4').propertyGroup('linzRes').set('alpha', '');
model.component('comp1').material('mat4').propertyGroup('linzRes').set('Tref', '');
model.component('comp1').material('mat4').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.component('comp1').material('mat4').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.component('comp1').material('mat4').propertyGroup('linzRes').set('Tref', '298[K]');
model.component('comp1').material('mat4').propertyGroup('linzRes').addInput('temperature');

model.component('comp1').common('amth_ht').label('Ambient Thermal Properties (ht)');
model.component('comp1').common('amth_ht').set('T_amb', 'T0');
model.common('cminpt').label('Common model inputs 1');

model.component('comp1').physics('ht').prop('PhysicalModelProperty').set('BackCompStateT', 1);
model.component('comp1').physics('ht').prop('PhysicalModelProperty').set('Tref', 'T0');
model.component('comp1').physics('ht').prop('AmbientSettings').set('T_amb', 'T0');
model.component('comp1').physics('ht').prop('AmbientSettings').set('LocationInfo', ['Location:\n  \n  United States\n  North America']);
model.component('comp1').physics('ht').prop('AmbientSettings').set('CoordinatesInfo', 'Coordinates:');
model.component('comp1').physics('ht').prop('AmbientSettings').set('ashrae2017LocationInfo', ['Location:\n  \n  United States\n  North America']);
model.component('comp1').physics('ht').prop('AmbientSettings').set('ashrae2017CoordinatesInfo', 'Coordinates:');
model.component('comp1').physics('ht').prop('RadiationSettings').set('opaque', 'ht.dfltopaque');
model.component('comp1').physics('ht').feature('solid1').set('k', {'kx'; '0'; '0'; '0'; 'ky'; '0'; '0'; '0'; 'kz'});
model.component('comp1').physics('ht').feature('solid1').set('rho', 'rho');
model.component('comp1').physics('ht').feature('solid1').set('Cp', 'cp');
model.component('comp1').physics('ht').feature('init1').set('Tinit', 'Tamb(0)');
model.component('comp1').physics('ht').feature('idi1').feature('lopac1').label('Layer Opacity');
model.component('comp1').physics('ht').feature('temp1').set('T0', 'Theat(t)');
model.component('comp1').physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.component('comp1').physics('ht').feature('hf1').set('q0', 'rect1(t/Tc)*q');
model.component('comp1').physics('ht').feature('hf1').set('h', 'ha');
model.component('comp1').physics('ht').feature('hf1').set('Text', 'Tamb(t)');
model.component('comp1').physics('ht').feature('hf1').set('materialType', 'solid');

model.component('comp1').mesh('mesh1').feature('size').set('hauto', 2);
model.component('comp1').mesh('mesh1').feature('ftet1').set('xscale', 4);
model.component('comp1').mesh('mesh1').feature('ftet1').set('yscale', 0.5);
model.component('comp1').mesh('mesh1').feature('ftet1').set('zscale', 0.5);
model.component('comp1').mesh('mesh1').feature('ftet2').set('xscale', 4);
model.component('comp1').mesh('mesh1').feature('ftet2').feature('size1').set('hauto', 6);
model.component('comp1').mesh('mesh1').run;

model.component('comp1').physics('ht').feature('solid1').set('k_mat', 'userdef');
model.component('comp1').physics('ht').feature('solid1').set('rho_mat', 'userdef');
model.component('comp1').physics('ht').feature('solid1').set('Cp_mat', 'userdef');
model.component('comp1').physics('ht').feature('solid1').set('minput_strainreferencetemperature_src', 'userdef');

model.study.create('std1');
model.study('std1').create('time', 'Transient');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature.remove('fcDef');

model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset.create('cpt1', 'CutPoint3D');
model.result.dataset.create('surf1', 'Surface');
model.result.dataset.create('cln1', 'CutLine3D');
model.result.dataset.create('cln2', 'CutLine3D');
model.result.dataset('surf1').selection.set([24]);
model.result.numerical.create('av1', 'AvSurface');
model.result.numerical.create('pev1', 'EvalPoint');
model.result.numerical('av1').selection.set([24]);
model.result.numerical('av1').set('probetag', 'none');
model.result.numerical('pev1').set('probetag', 'none');
model.result.create('pg1', 'PlotGroup3D');
model.result.create('pg2', 'PlotGroup3D');
model.result.create('pg6', 'PlotGroup2D');
model.result.create('pg5', 'PlotGroup2D');
model.result.create('pg3', 'PlotGroup1D');
model.result.create('pg7', 'PlotGroup1D');
model.result.create('pg8', 'PlotGroup1D');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').create('con1', 'Contour');
model.result('pg2').create('iso1', 'Isosurface');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').create('con1', 'Contour');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').create('con1', 'Contour');
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').create('tblp1', 'Table');
model.result('pg3').create('glob1', 'Global');
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg8').create('lngr1', 'LineGraph');
model.result.export.create('anim1', 'Animation');
model.result.export.create('plot1', 'Plot');
model.result.export.create('data1', 'Data');

model.study('std1').feature('time').set('tlist', 'range(0,1,ts)');

model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').set('clist', {'range(0,1,ts)' '0.978[s]'});
model.sol('sol1').feature('t1').set('control', 'user');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,ts)');
model.sol('sol1').feature('t1').set('rtol', '0.0001');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 5);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature('d1').label('PARDISO (ht)');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('i1').label('Algebraic Multigrid (ht)');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (ht)');
model.sol('sol1').feature('t1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').runAll;

model.result.dataset('cpl1').set('quickplane', 'xz');
model.result.dataset('cpl1').set('quicky', 'W/2');
model.result.dataset('cpt1').label('Heater point');
model.result.dataset('cpt1').set('pointx', 'd');
model.result.dataset('cpt1').set('pointy', 'xhot');
model.result.dataset('cpt1').set('pointz', 'yhot');
model.result.dataset('cln1').label('Ty');
model.result.dataset('cln1').set('genpoints', {'d' 'xhot' 'yhot'; 'd' 'L' 'yhot'});
model.result.dataset('cln2').label('Tz');
model.result.dataset('cln2').set('genpoints', {'d' 'xhot' 'yhot'; 'd' 'xhot' 'W'});
model.result.numerical('av1').label('Average temperature');
model.result.numerical('av1').set('table', 'tbl1');
model.result.numerical('av1').set('unit', {'degC'});
model.result.numerical('pev1').label('Center temperature');
model.result.numerical('pev1').set('data', 'cpt1');
model.result.numerical('pev1').set('unit', {'degC'});
model.result.numerical('av1').setResult;
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('looplevel', [395]);
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('unit', 'degC');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('con1').set('unit', 'degC');
model.result('pg1').feature('con1').set('colortable', 'TrafficLight');
model.result('pg1').feature('con1').set('resolution', 'normal');
model.result('pg2').label('Isothermal Contours (ht)');
model.result('pg2').set('looplevel', [1]);
model.result('pg2').feature('iso1').label('Isosurface');
model.result('pg2').feature('iso1').set('number', 10);
model.result('pg2').feature('iso1').set('colortable', 'ThermalLight');
model.result('pg2').feature('iso1').set('resolution', 'normal');
model.result('pg6').label('Thermography');
model.result('pg6').set('data', 'surf1');
model.result('pg6').set('looplevel', [971]);
model.result('pg6').feature('surf1').set('unit', 'degC');
model.result('pg6').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg6').feature('surf1').set('resolution', 'normal');
model.result('pg6').feature('con1').set('unit', 'degC');
model.result('pg6').feature('con1').set('number', 10);
model.result('pg6').feature('con1').set('colortable', 'Traffic');
model.result('pg6').feature('con1').set('resolution', 'normal');
model.result('pg5').label('Center plane');
model.result('pg5').set('looplevel', [1]);
model.result('pg5').feature('surf1').set('expr', 'comp1.T');
model.result('pg5').feature('surf1').set('unit', 'degC');
model.result('pg5').feature('surf1').set('colortable', 'HeatCamera');
model.result('pg5').feature('surf1').set('resolution', 'normal');
model.result('pg5').feature('con1').set('unit', 'degC');
model.result('pg5').feature('con1').set('number', 10);
model.result('pg5').feature('con1').set('resolution', 'normal');
model.result('pg3').label('Temperature response');
model.result('pg3').set('xlabel', 'Time (s)');
model.result('pg3').set('ylabel', 'Temperature (degC)');
model.result('pg3').set('xlabelactive', false);
model.result('pg3').set('ylabelactive', false);
model.result('pg3').feature('ptgr1').set('data', 'cpt1');
model.result('pg3').feature('ptgr1').set('looplevelinput', {'all'});
model.result('pg3').feature('ptgr1').set('unit', 'degC');
model.result('pg3').feature('ptgr1').set('linecolor', 'blue');
model.result('pg3').feature('tblp1').set('table', 'tbl1');
model.result('pg3').feature('tblp1').set('linecolor', 'blue');
model.result('pg3').feature('glob1').set('expr', {'Tave(t)' 'Thot(t)'});
model.result('pg3').feature('glob1').set('unit', {'' 'degC'});
model.result('pg3').feature('glob1').set('descr', {'Average' 'Hot spot'});
model.result('pg3').feature('glob1').set('linecolor', 'green');
model.result('pg7').label('Ty');
model.result('pg7').set('data', 'cln1');
model.result('pg7').set('looplevelinput', {'manual'});
model.result('pg7').set('looplevel', [1]);
model.result('pg7').set('xlabel', 'Arc length (mm)');
model.result('pg7').set('ylabel', 'Temperature (degC)');
model.result('pg7').set('xlabelactive', false);
model.result('pg7').set('ylabelactive', false);
model.result('pg7').feature('lngr1').set('unit', 'degC');
model.result('pg7').feature('lngr1').set('legend', true);
model.result('pg7').feature('lngr1').set('resolution', 'normal');
model.result('pg8').label('Tz');
model.result('pg8').set('data', 'cln2');
model.result('pg8').set('looplevelinput', {'manual'});
model.result('pg8').set('looplevel', [1]);
model.result('pg8').set('xlabel', 'Arc length (mm)');
model.result('pg8').set('ylabel', 'Temperature (degC)');
model.result('pg8').set('xlabelactive', false);
model.result('pg8').set('ylabelactive', false);
model.result('pg8').feature('lngr1').set('unit', 'degC');
model.result('pg8').feature('lngr1').set('legend', true);
model.result('pg8').feature('lngr1').set('resolution', 'normal');
model.result.export('anim1').set('plotgroup', 'pg6');
model.result.export('anim1').set('giffilename', 'C:\Users\Jie\Desktop\Cell optimization\Bulk cell-kxyz1.gif');
model.result.export('anim1').set('solnumtype', 'inner');
model.result.export('anim1').set('solnum', [1]);
model.result.export('anim1').set('maxframes', 200);
model.result.export('anim1').set('title', true);
model.result.export('anim1').set('fontsize', 12);
model.result.export('anim1').set('title', 'on');
model.result.export('anim1').set('legend', 'on');
model.result.export('anim1').set('logo', 'off');
model.result.export('anim1').set('options', 'on');
model.result.export('anim1').set('fontsize', '12');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('axisorientation', 'off');
model.result.export('anim1').set('grid', 'off');
model.result.export('anim1').set('axes', 'off');
model.result.export('anim1').set('showgrid', 'on');
model.result.export('plot1').set('plotgroup', 'pg6');
model.result.export('data1').set('data', 'surf1');
model.result.export('data1').set('unit', {'degC'});
model.result.export('data1').set('filename', 'C:\Users\Jie\Desktop\Cell optimization\Sim-Tsurf.txt');
model.result.export('data1').set('location', 'regulargrid');
model.result.export('data1').set('regulargridx2', 20);
model.result.export('data1').set('regulargridy2', 20);
model.result.export('data1').run
out = model;
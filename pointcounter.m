%我是一个图片分数计算器



% clear;close;
% [f,p] = uigetfile('*.*','选择图像文件');
% I=imread(strcat(p,f));
function [s_off,m_off,weight_by_ent,ent] = pointcounter(I,channel_sen)%diff_sen差别敏感系数，越大，就对通道不一致越不敏感，就越不会凸显主要通道的值
mr=mean(mean(I(:,:,1)));
std_r=std2(I(:,:,1));
mg=mean(mean(I(:,:,2)));
std_g=std2(I(:,:,2));
mb=mean(mean(I(:,:,3)));
std_b=std2(I(:,:,3));
m=[mr,mg,mb];
std=[std_r,std_g,std_b];

% std=[std_r,std_g,std_b];
% pr=abs(mr-128)/255+abs(std_r-73)/255;%你可以算一下，最大标准差就是255
% pg=abs(mg-128)/255+abs(std_g-73)/255;
% pb=abs(mb-128)/255+abs(std_b-73)/255;
%差别敏感系数，越大，就对通道不一致越不敏感，就越不会凸显主要通道的值
% pr=(abs(mr-128)/128+abs(std_r-73)/182)*diff_sen;%你可以算一下，最大标准差就是255，182=255-73
% pg=(abs(mg-128)/128+abs(std_g-73)/182)*diff_sen;
% pb=(abs(mb-128)/128+abs(std_b-73)/182)*diff_sen;
% p=[pr,pg,pb];
% w=(p-min(p));
% s_off=w.*(73-std);
% m_off=w.*(128-m)/2;



ent=[0,0,0];
for i=1:3
    ent(i) = entropy(I(:,:,i));
end
weight_by_ent=ent;
weight_by_ent=ent/max(weight_by_ent);
weight_by_ent=1-weight_by_ent;


m_off=(128-m).*weight_by_ent*channel_sen*0;
% s_off=(73-std).*weight_by_ent*channel_sen*3;
s_off=std.*weight_by_ent*channel_sen;

end








%{


                               .......... ....                  ......  ...   ..        .   ....                                   
                               ..............                   ...........             ..  ....                                   
                                .. .........                ....................        .. .........                               
                                .............             ..........................     ...............                           
                         ..........,@@@@@@@@.................]/@@/[[```[/OOO@@]]...........,@@@@@@@@....                           
                        .........,@@@@@@@@@@`........,/@@@O//\oo\/o\]=ooo/ooo\oooO\\[]....,@@@@@@@@@\...                           
                       ........,@@@@@@/\@@@@@.....,@@\/\oooooooooooooooOOOOOOO/ooo\/OO/\`,@@@@@@@@@@@\...                          
                        . ...,@@@@@@/...\@@@@^.,@O\//ooooOOOo\ooo//=^oooOOOOOOOOo/ooooo@,@@@@@@`\@@@@@^..                          
                        ..../@@@@@@`...,]@@\@@[\ooooooooOOOO@OOOOo\\O/oooOOOOOOO@/\ooooO@@@@@@`..@@@@@@`........                   
                       .../@@@@@@`[O]]]`]**/O/oooooooOOOOO@@@@OOOOoOO^oooooOO@O@@@\\=[/@@@@@@^..//OO@@@\........                   
            ......  ..../@@@@@@@...,O@@@@@@/=oooooOOOOOOOOOOOOOOOOOOOO/\ooooOO@@@@@Oo*@@@@@@O,@O`=`[\[\/@`......                   
          ..............=@@@@@@@^.,@@@@@@@^OOOOOOOOOOOOOOOOOOOOOO@@@@oO///o^=oO@@@@@O@@@@@@@^`,@/\o/]`\/O/\.....                   
        ............   ..=@@@@@@@.@@@@@@@\OOOOOOOOOOOOOO@OOOOOOOOOO@@OoO\/o/]oooO@@@@@@@@@@/**,OO\/oooooo/^\.....                  
      ...............  ...=@@@@@@@@@@@@@/,[OOOOOOOOOOOOo@oooOOOOOOO@@@\\O//O/o=\/O@O@@@@@@@@^`=/Oooooooo/OO\\.....                 
      ...............   ...,@@@@@@@@@@@^...=OOOOOOOOOOO@@ooOOOOOOOO@@@\OoOo/O]/\o\O@o`\@@@@@@`*/@O\ooooooooO\O......               
      ...............   .....@@@@@@@@@O..../OOOOOoOOOOO/@OoOOOOoOOOO@@*=\/O/O^ooo/o\^,`=@@@@@@\@@@OOOOOOOOOOOo\.....               
. ... ................ .....=@@@@@@@@O/..*]/OO\**=OOOO/*\OooooooOOOO@O..,O=o\\\/\=o^O^,`/@@@@@@@@@@OOOOOOOOOOOO^........           
  ... ................ .....@OO@@@@@@^\Oooo//ooO\oOOOO..,@oooOooOOoo@O....\^\[\O\oo\/O^`*`,@@@@@@@@@@OOOOOOOOOO@`......            
..          ......      ...@OOOO@@@@OooOooooo==oooooO^...\OoooO\`Ooo/@*.....\]/\/O/o/\`/**,*\@@@@@@@@@@OOOOOOOOo@.......           
.                     ..../OOOOO@O@@Oo/Ooooo=^/o=oooO.....Oooo^\*/oo/O^......,@O\Ooo`\^\oo]//\@@@@@OO@@@@OOOOOOoo^......           
... ....        ........./OOOOOOOO@@O/OO\oo\**o\oooO^......O/``/o=^[`@=.....,..,O[O\\o@=OOO\=\O@@@@@OO@@@OOOOOOooo^.....           
. .. ...        ........]OOOOOOOOO@@O\@@Ooo^*`O=ooo/.....[].\*,*OOO`*=O`,/[.]`....\,O`@oOOOOo/o@@@@@@@@@@@OOOOOoooO.....           
..   .....      .......=OoOOOOOOOO@@@o@OOOo^^\O\//@@@@@@@\...\*,\\\O`.\`..,/@@@@@@\`*@@OOOOOooo@@@@@@@@@@@@OOOooooo^.....          
   ....    .    ......,OoOOOOOO@oO@@@o@OOOOOOo@=@@@[@@@@@@@\..,*``,`,`=`.O@@\@@@@@@@@@@OOOO@@OoO@@@@@@@@@@@Oooooo\\O`....          
               ......,/ooOOOOO@@@@o\@OO@OOOOOO@@@..=@@@@@@@@/....*****...=`=@@@@@@@@@@\@OOO@^.=OO@@,@@@@@@@@ooooooo^\....          
               .....,@ooOOOOO@O@o/@@@@@@OOO@OO@@...@@@@@@@@@@..............,@@@@@@@@@@o@OOO@OO`=@@`.@@@@@@@@oooooooo=^...          
                ....@/ooO@@@OOO/O@@@@@@@@@O@@@O@^..=@@OO@OOO@...............@OO@@OO@@^o@OOO@\o^=@`..=@@OO@@@Oooooooo\O...          
                ...@\ooOO@@@@o^@@@@@@@@@@@@@@@OO^`..\@OOOOO@`...............=@OOOOOOOo\@OO@/o^,/.....@OOOO@@@oooooooo=\..          
              ..../\oooo@@@@/o/@@@@@@@@@@@@@@@OO^.....[\/[`...................[OOO`.^,=@OO@^]@^......=OOOOO@@OooooooooO`.........  
                .=^ooo\@@@@@oo@@@@@@@@@@@@@@@@@\^,..*...........................**.=*`@OoOO@/`.......=OOOOOO@^oooooooooO........   
        . ......,/\o\/O@@@@^oO@@@@@@@@@@@@@@@@@@@`**...........................^^*\^*=Oo\\@`..........OOOOOOO@\oooooooo/^.......   
        . ......O/=oo/@@@OO@OO@@@@@@@@@@@@@@@@@@@@\...............]..,`..........,@/=@OO`=`...........=ooOOOO@ooooooooooO... ...   
       ........O^ooo\O@@@@@@O@@@@@@@@@@@@@@@@@@@@@@@@\].......................],`@@OO`*...............=OoooOOOooooooooOo/^.......  
        ......=OooooO@@@@@@@@@@@^.........//@@@@@@@@@@@@@@@@@@@@@]]]]]]@O[`.....O/\`........O..........@ooooOOOooooooooO/@`.....   
       ......=Oo/ooO@@@@OOO@@@@@...........O,@O@@@@@@@@@O\^,[\@@@OO`**@@\................../@..........@ooooooOooooooooOo/\.....   
        .....OoooooOOO@OOOO@@@@^............\O..[O@@@@@O\/....*.@OO^.=@O/\...............,^./^.........\OoooooOooooooooO\/@.....   
       ...../oooo/OOOOOOOOO@@@@.....................\OO@`,\]`..O@O\@^@o`@.\`......  .......@....   ....=OoooooOoooooooooOoO^.....  
        ...=O=ooooOOOOOOOOOO@@/........... ...........`.......@OO@@@@@@@@`.,@@`... .........       . ..=@oooooooooooooooO\o@.....  
        .../oooooOOOOOOOOOOOO@^...............................OOOOO@@@@O@\]@O@@`..... ..           ....,@ooooooooooooooo//oo^...   
        ../=oooooOOOOOOOOOOOO@............=`..  .............=OOOOO@@@@OO@@@@@@@^..... .           .....@ooooooooooooooo\Ooo@...   
..    ...=//ooooOOOOOOOOOOOOO@............=[O\..............,@OOOOO@@@@O/O@@@@@@@@........ .....     ...@ooooooooooooooooOOoO^...  
      ...@o/ooooOOOOOOOOOOOOO/...........@@`./..............@oooooOOOO@OooO\@@@@@@@\...... ... .     ...@ooooooooooOooooo/OOo@`..  
.  ...../o^ooooOOOOOOOOOOOOO@^..............,^.............@oooooo@OOOOOoooO^\@@@@@@@\...........  .....@ooooooooOOOOOooooOOoO^..  
. .....=@\/ooooOOOOOOOOOOOOO@^............. ............,@@/oooooo@ooo=Ooooo/\@@@@@@@@@O`.........  ....@ooooooooOOOOOOooooO/o@..  
.......@^=\oooo@OOOOOOOOOOOO@^.........   ...........,@@@Ooooooooo@oo//Ooooooo@@@@@@@@@@@@\...... .....=@ooooooooOOOOOOOOo/Oo\@^. .
......=O[\oooo\@OOOOOOOOOOOO@^.........  .........../@@@@@ooooooo^\[@\O\ooooo\\@/@@@@@@@@@@@@@@@.......=@ooooooooOO@@@@OOOOOOOO@...
......Oo/[oooo=@OOOOOOOOOOOO@`......... ........./@@@@@@@@@Oo/\,^`]@@@@o/o/o//@@@@@@@@@@@@@@@@@@OO^..../OooooooooO@@@@@OOOOOOOO@...
.....,@ooooo/\=@OOOOOOOOOOO@@^......... .....,/@@@@@@@@@@@@@@@@OO@@@@@@@/]/@@@@@@@@@@@@@@@@@@@@O//....,OOoooooooo@@@@@@OOOOO@OO@...
.....=O^/,/*oo=@OOOOOOOOOOO@O^..............,\@OO@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O@O@@@@@@@@@@@@@@oo^..../OOooooooOO@@@@@@@@OOO@OO@^..
.....@O\***=oo=@OOOOOOOOOOO@O^.................,\@OO@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O@O/\@@@@@@@@ooO.....@OooooOooOO@@@@@@@@OO@@Oo@...
.....@O`***=oo=@OOOOOOOOOOOOo@...................,@@@O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O\@@@@@@O\\O`....=OOoooOOOOOO@@@@@@@@OO@@Oo@...
.....@//****/ooOOOOOOooooooOo\^........ ............/@`=@@@@@@@@@@@@@@@@@@OOOO@@@@@@/`.\@@o\OO`......@OoooOOOOOOOO@@@@OOOOO@Oo\/...
.....@^``**,oooOOOOOooooooOOo=O`..........   .......@\OOoO@@@@@@OOOOO@@@@@@\[`*...\.....@@@[........=OOOOOOOOOOOOOOO@OOOOOOOO/@....
.....@^`*****oooOOoooooooooO,`\=`.......        ...=^..*,\\@`....[.....[`.@\^*....,.................@OOOOOOOOOOOOOOOOOOOoOOOOo^..  
.....OO******oooooooooooooo\,O=`........       ....@OO@@@]/`...............O`*.,/@@^.............../OOOOOOO@OOOOOOOOOOOoO/oOo``... 
 ....,@,*****=oooooooooo\o^O*=@O....   .       ....@@@@@@@`.................\OO@@@@@..............=OOOOOOOOOOOOOOOoOOooOOooO\`...  
......=/]****,oooooooooooooO\**\O.......       .../@@@@@@`.....    ..........=@@@@@@^...........,/OOOOOOOOOOOOOooOooooOO\oO......  
.......@\,****=o\O\oooooooo=^\...[`.....      ...=@@@@@@^.....     ...........=@@@@@@^........./\OOOOOOOOOOOooooOO/OO\O\oO....... .
. .....,OOO`,`*oo=Oooooooooo@.,\`...,...    .....@@@@@@/......     ............=@@@@@@..........OOOOOOOOOOooooooOOO/OOOOo^.......  
........,\//\/`ooOO@/\\ooo,o\^...,[[[`..    ....=@@@@@/.....       .............\@@@@@@.......,OOOOOOOOOoooooooO@/OoO/[`........   
    .. ....o`*,\ooo\@O/o/\][^\`.........    ....@@@@@/..           ..............=@@@@@@...../OOOOOOOOoooooooo\Ooo/...... .. ..    
        ...,oo`*,oooOOO@\\`^^,\`...... .    ...@@@@@/...           ...............=@@@@@@,.O@@OOOoooOoooooo/oO/.........           
       .......,\...@OoOO\[O\`\,/`..... .......,[[[[[....           .................O/[\/.OOOOooOOooO[`..,[`,^.......              
       ..............\O@OOO\,[[[[*,`... . .............            ...................../@@OOO[`...................... .           
         ...  ... ...........[\OOO[....                            ............. .. .. .\`............. ...  .. ..  .              
                   .....................                           ............. .. .. ................                            
                     ..... ........   ..                           ............. ..   .......    .. ...                            





















                               .....................*,`..........                                
                              ............,]OOOOOoOO\@^.........                                
                              ......,@OOO@OOOOoOOOO@OO^.........                                
                              ......*@o@O@OoOooo[\@@@@O`........                                
                            ........*OoOO@@OO@O/O\=@@@OO\`.........                             
                            ........oO@@@^=@O*=@@@@O@@@OOO\........                             
                            ........=@@@@\],O\=@@@@@@@O@Oo@\........  ..                        
                            ........=@@@@O@O.*.\@\@@@@o@@O,O\........                           
                              ......=@@@@\***....=@@@*.O@@@\O`....................              
                              ......=@@@@@\****.,@O`...=@@O@OO*............ ....   .            
                              ......=@@@\*[*\OO@@\......=@@O@@O`................                
                              ......=@@@@^../@OOOOOOo\O..\@OOO@@\...............                
                            ........=@@@@OOO@@@@OO/....o..O@^\OO@O..............      ..        
                            ........,@@OOOO@@`*..,*]*.*O`..\@^,@OOO`............  ...   ..      
                            .........\@Oo/@/...*,OOO@^*O/`...\O`\@O]o]................. ......  
                             ........=@^O@O*.*..oOOO*O*.,O\....\@O@@@OOOO`............. ........
                            . .......OOO@@OoOO/.*OO*.=@@@@@^.......*\OOOOOOO\]**................
                             .......O@@O@@^oo..**O`...[@@@@@`.........,O@O@@@@@O\,oO@O]*........
                            .......,@@oO@O^oo..*O[.....=@@@@@`...........,O@@@@OOOOO`,\@O`......
                            .......=@OOOOO*/*o,O`.......=@@@@@^.............*[OO@OOooOo,O@`.....
                        ..........=@@O@@O`.*.*Oo.........=@@@@@^.................[OO\*,o/OO*..,]
                        ........,@@@OOOOOO^***,o..........,@@@@@^.......... ........\OOoO\`*,/,O
                        ......./@@@\OO@OO`...*=O`...........\@@@@`....................,OoOOoo\=o
                        ...,]/@@/[oo/@@^,...*..,/o]..........=@@@@^....................=@@@\ooo/
.. ......................=@@@@@@OO/@@@@@*.....*]@@@@O]]]]]]`..,@@@@@^..................=@@@\OoO*
.........................=@/\O@\@@@@@@@@@O@@@@@@@@@@@@@@@@@^...=@@@@@\****.............=@@@OOO/.
..........................\]*O\=@@@@@@@@@@@@@@@@@@@@@@@@@@O.....O[[*.*oOO\`............=@@OOO@^.
.. ................`......\oOO@@@@@@@@@@@@@@@@@@@@@@@@@@@/......\\*,o/\.*[[............O@@@OO@^.
................,/@^.......*/@@@@@@@@@@@@@@@@@@@@@@@@@@/*.......=O....,O*.............=@@@OO=O`.
............]/O/`*......../@O@@@@@@@@@@@@@@@@@@@@@@O/................................,@@@@O[O^..
./OOOOOO@@O[`...........,O/.,O@@@@@@@@@@@@@@OOOOOOOoO...............................,OO@@@oO^...
*OO@@@/`.............,/@^*,@@@@@O@@OOOOOOO.,OOO[....\*...................... ....../OO@@OoO`....
.=@OOO*............,OooOO@@@@[,O@@OOOOOOO/..\O`......o...........................,OOO@@OO/......
...\OOOO\***.*..,OOOOO@@@O[.*/O@@@OOO/`**`..*O\*.....[*........................,OOO@@@Oo........
......[OO@@@@@@@@@@O[[*...,OO@@@`*O\]]]]]O`..,O`....,]`.....................,/OO@/oOO*..........
.....*oOOO[[*.........../OO@@/*...O@@@@@@@^...=@\/@@@@O`/OO^*............,OOOO/O@@O*............
.................**,/OOOOO[.......=@@@@@@@^...,@@@@@@@@^OOOOoo\/o]ooo/O@@O/[/O@@/.......... ....
............,oOoo\OOO/*...........,@@@@@@@^....=@@@@@@@^.........*=OO`**,O@@OO[...........  ....
.  ...........,OO/*................=@@@@@@^.....=@@@@@@O*.....*]/`]]O@@O\oO`.............  .....
...........,OO`....................,@@@@@@^......\@@@@@@/OOOOOOO/[[`..O^*..... .............  ..
     ....//*........    .. ........ =@@@@@@`.....,@@@@@@@\...................    .......        
     .......... ....            ....=@@@@@@^......=@@@@@@@@\`................                   
        .... ...                ....=@@@@@@^ ......=@@@@@@@@@@]...............                  
        . .... .                .. .=@@@@@@^.........[@@@@@@@@@@^........ ..                    
                               .....=@@@@@@^....    ...\@@@@@@@@@^......                        
                                ....=@@@@@@O....     ....\@@@@@@@@^.....                        
                                ....=@@@@@@O........    ..,@@@@@@@@^....                        
                                ....=@@@@@@O........    ....\@@@@@@@`...                        
                                .....=@@@@@O......      .....,@@@@@@\...  ....                  
                                 ....,@@@@@^....   .    .......\@@@@@^..  ....                  
                                 .....=@@@@/....        . ......=@@@@@`.......                  
                                 .....=@@@@O....        .........=@@@@@.......                  
                                ......*@@@@O....              ....O@@@@@\.......                
                                ......./@@@@^...              ....,@@@@@@^.... .                
                                .......O@@@@@`..  ..          .....\@@@@@^.... .                
                                ......=@@@@@@^...             .....=@@@@@@`....                 
                                ......,@@@@@@^....            .....=@@@@@@^.....                
                               .......=@@@@@@^...             ....=@@@@@@@^.....                
                                ......@@@@@@@@^.          ..  ....O@@@@@@@^......               
                                ......=@@@@@@/..          ..  ....=@@@@O/........               



%}   


% pr=exp(-(abs(mr-128)/255+abs(std_r-73)/255));%你可以算一下，最大标准差就是255
% pg=exp(-(abs(mg-128)/255+abs(std_g-73)/255));
% pb=exp(-(abs(mb-128)/255+abs(std_b-73)/255));
% sum=pr+pg+pb;
% wr=(pr/sum);
% wg=(pg/sum);
% wb=(pb/sum); 
% w=[wr,wg,wb];
% w=mapminmax(w,0,0.7);

% end
clear all
fname = ['U:\com_vision\Images\out_manmade_1k\sun_aabghtsyctpcjvlc.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aabwvttncoffagty.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aadgespdawrxowdb.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aaerilqamknsubxp.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aafrekwxjonzjktv.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aagiuszsslybzsqr.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aahvwqdsxysjumwv.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aajdfgomwuyaybdx.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aajrrubsiywwxfnn.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aakhloyzxmmeyqdv.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aaoonjpbnjdpzfnu.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aaorpzqjcpfvnxvx.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aaqgjlskyhetnifo.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aaqshclgwiwhlbkw.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aaqwtkmqdqsbfjxk.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aaqzzkbirqqcftnh.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aasmuwvjwqmyxirs.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aatsyscvqwmckafx.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aavduntxyweaxgpe.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aawejawauhafqfcc.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aawwtisisnzkshyv.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_abahgfgnjrgaoewn.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_abdiqerzpnyfpxlg.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_abdzeibppilauovt.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_abfnwdpmfqcbkgba.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_abhbibbmachoeepq.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_abhjteqstcfyacpq.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_abiimobkkqjuccks.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_abjugfhojqgbyepp.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_abkdaqwzvdweshow.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_abkyokpwmyuopxdh.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_abllxjlemmdsgtlp.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_abrjgpetbfjgcdeg.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_abuigwrwidepthxe.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_abxyywdotdsuuevt.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_acbcymyxjhkdanvs.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_acccqeniuxulqvhw.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_acciepafuyhrthvt.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_accjmxnrsmbmhjpg.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_accvlxkxxcatprll.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_acfnidswqwftcpam.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_acictwjtsespmljt.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_acpussiuvviyxzll.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_acqjipzvzfbgdvif.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_acqjthtjrluwygzp.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_acqoqazwkgqdiuzh.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_acukmokofsbuhbmg.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_acunorujjxrvnqkx.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_adfghiulakupaqcj.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_adhowuhnschskehc.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_adhrqoimlpnhwwqr.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_adjfjbhekhbrafmk.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_adlkjwburzvorqaq.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_adlxjyyzmawatgwl.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_adoebuqygdcbrgog.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_adoofsmqqyoagjdq.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_advfapayzuqvocot.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_adxomzwzeqaoqzym.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aebmburwnarjjsum.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aecognlmonesrqcd.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aeddeibpryaxryyo.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aegbwhogssrdscxn.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aehptjoywephybbn.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aehrzocecvtimujc.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aeigiuuicpnmgmus.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aeiiivwbvduaslkx.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aejqkpfvareivgar.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aenigojtbybidwuq.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aeocvsfvrzghocnb.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aeoczbwsmwmlvfac.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aeoggzivyjwrbnbs.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aepfypprvbxcxygl.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aeqvckutfmebujtg.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aesibhfkymnfnxjv.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aetdhkhyvnihhzqu.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aewhuupclpahykof.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_afdhcldpwvsooazw.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_afeamhfmvciqdvuu.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_affkrkhrqhbcmlbj.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_afjpfomkltxlgdqw.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_afudhvuapixtvird.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_afvqwxoiqgofimrb.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_afwdcuqfucobuzen.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_afxuchtyzfqcfite.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_afyiiwdqdljbxqsy.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_afyzpugszbozcscp.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_agdjpxuxjubcaimd.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_agfkhgaoxwtqybqy.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aghqpdrnitevyedj.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_agixmnegbkyxuanj.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_agkikvjssyjwzfgk.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_agoqcotiuwcqiarw.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_agpmhgclebcwzxpx.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_agpqyirbomasjaip.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_agrhnwetypjgowyd.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_agruczgdxsknninj.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_agsnrmqnspbwkgeu.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_agwcwrrvwudchfyd.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_agyjsmjvnamxszkf.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_agzpccodlvnkwjnd.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_agzxmplzdpyrckuk.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ahgaoofhfbuaxyqb.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ahisjbxkzdyoauum.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ahllhhschugcgosb.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ahllvbntwywdocqi.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ahmkayjqxstemhgg.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ahsisagksxfgvpvd.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ahtxruxkedqmqgzb.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ahvqoqsgncotmkld.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ahvuzjbtouklafim.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aidgbatmevitepwn.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aidmiyaupldchajt.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aiephdtbuvilpbxn.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aihuibprctxbdzru.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aijobuylxxlbjvew.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aikogdmqntfvcrug.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ailwijjhtyxqmevi.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aimyphvdapxyapdb.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aiqcqqhbgbgriatd.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_airjyfbxixcgpgbw.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aitevdquyzlyjlqp.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aiujhwzzsoonkewa.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aivmxxnwlvluqpxb.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aiwxbaalhxdditjo.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aizyipvcqbujfpgw.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajalardwzcquhsvh.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajawtmtittumqgoc.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajcjafrnakuuykfp.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajcrjaprydvjodsp.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajcvzyfyzeoxsmyb.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajdawefizqlzoyqq.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajdfgzpttnvpcpde.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajdrqnyihfmatmzj.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajiufksyqsfxetdu.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajixohzbtihcjqwe.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajkgzshekufrkqbk.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajksnfjdxnypdllh.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajpqomllvnzcsazb.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajqragpyjjntnktx.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajsoyyrneaaxgbdj.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajstfgsafgbatmwb.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajtmuzgtvgwecxls.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajwpyqwcckegezeg.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajxtxooiwnpnpgla.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajybyfbhxlhuqyqf.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajzjozbgnfsclxis.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_ajztlwbcsyncbfzq.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akbbxewfnuxtxfkd.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akbntoruixcqpjry.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akcbjigzpwnmwham.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akchecauzxquubel.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akcxnfinxackjbcm.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akghhvlbfemighun.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akgkskqfbobllncv.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akhghvxuyeykioal.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akjkwyzvjclpteza.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akkucpeeixebocfl.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akmjevrohastewud.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aknaghwdfpzcmzwl.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akoepvlfylepqisl.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aktgxpdxzokxhzwd.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aktsecofhnridmki.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akusyviiipcciqbu.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akyzictkavhkdepo.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akzplmxhqavviutt.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_alchntdrksbaiiur.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_alewytlvnsaknhfm.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_algqmkjmqfdlvoyz.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_alhavfbsfrntubql.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_alhfavvprauzwqzo.jpg'];




im = imread('U:\com_vision\Images\out_manmade_1k\sun_aawejawauhafqfcc.jpg');
tg = imread('U:\com_vision\Images\mosaic_target1.jpg'); % Target Image
[tgrp,tgcp,tgl] = size(tg); % tgrp,tgcp : Number of pixel in Row and Column in target image

np = 200; % Number of pixels
nt = 10; % Number of tiles

nrt = ceil(tgrp/np); % Number of tiles in row
nct = ceil(tgcp/np); % Number of tiles in column


tgf = imcrop(tg,[1 1 np-1 np-1]);
[fn,fl] = size(fname);
for i = 1:fn
    im = imread(fname(i,:));
    img = crop(np,im);
    dis1(i) = calcs(img,tgf);
    edw(i) = edgepixel(img);
end



img = crop(np,im);


ed = edge(rgb2gray(img));
edh = imhist(ed); 
edh = edh./sum(edh(:)); %% normalisation


figure(1), hold on;
subplot(2,2,1),imshow(im);
subplot(2,2,2),imshow(img);
subplot(2,2,3),imshow(ed);

hold off;


function img = crop(np,im)
%%% Gaussian smooting and resize twice
    [m,n,l] = size(im);
    
    img = imgaussfilt(im,2);
    img = imresize(img,np*2/min(m,n));
    img = imgaussfilt(img,2);
    img = imresize(img,0.5);
    [m,n,l] = size(img);
    if m<n
        img = imcrop(img,[round((n-m)/2) 1 np-1 np-1]);
    else
        img = imcrop(img,[1 round((m-n)/2) np-1 np-1]);
    end
end





function chi = calcs(img,tgf)
%%% Calculating chi-square distance
    h = imhist(img); % Histogram of the tile
    h = h./sum(h(:)); %% normalisation

    
    tgh = imhist(tgf); %Histogram of target image
    tgh = tgh./sum(tgh(:)); %% normalisation

    s = h+tgh;
    s(s==0) = 1;
    chi = 0.5*sum((h-tgh).^2./s); %chi-square distance

end



function edw = edgepixel(img)
%%%Calculate number of pixel of edges
    ed = edge(rgb2gray(img));
    ed = imhist(ed); 
    ed = ed./sum(ed(:)); %% normalisation
    edw = ed(2);
end








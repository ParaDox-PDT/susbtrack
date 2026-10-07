from pathlib import Path
import html

OUT=Path(r'D:/my_projects/susbtrack/docs')
parts=[]
def add(s): parts.append(s)
def group(name,x=0,y=0): add(f'<g id="{html.escape(name)}" transform="translate({x} {y})">')
def end(): add('</g>')
def rect(x,y,w,h,rad=0,fill='#fff',stroke=None):
    add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{rad}" fill="{fill}"'+(f' stroke="{stroke}" stroke-width=".7"' if stroke else '')+'/>')
def text(s,x,y,size=14,weight=400,col='#111',anchor='start'):
    add(f'<text x="{x}" y="{y+size}" font-family="SF Pro" font-size="{size}" font-weight="{weight}" fill="{col}" text-anchor="{anchor}">{html.escape(s)}</text>')
def circle(x,y,r,fill='#111'): add(f'<circle cx="{x}" cy="{y}" r="{r}" fill="{fill}"/>')
def path(d,stroke='#111',width=1.7,fill='none'):
    add(f'<path d="{d}" fill="{fill}" stroke="{stroke}" stroke-width="{width}" stroke-linecap="round" stroke-linejoin="round"/>')
icons={
 'search':'M15 15l6 6M17 10a7 7 0 1 1-14 0 7 7 0 0 1 14 0',
 'back':'M15 5l-7 7 7 7', 'chevron':'M9 6l6 6-6 6',
 'plus':'M12 4v16M4 12h16',
 'calendar':'M3 6h18v15H3zM7 3v6M17 3v6M3 11h18M7 15h2M13 15h2M7 19h2',
 'card':'M3 5h18v15H3zM3 9h18M7 15h5',
 'clock':'M12 22a10 10 0 1 1 0-20 10 10 0 0 1 0 20M12 6v7h5',
 'db':'M4 5c0-4 16-4 16 0s-16 4-16 0M4 5v6c0 4 16 4 16 0V5M4 11v7c0 4 16 4 16 0v-7',
 'check':'M12 21a9 9 0 1 1 0-18 9 9 0 0 1 0 18M7 12l3 3 7-7',
 'service':'M8 3h8l1 3 3 2v8l-3 2-1 3H8l-1-3-3-2V8l3-2z',
}
def icon(name,x,y,size=22,col='#111'):
    group(name,x,y);add(f'<g transform="scale({size/24})">');path(icons[name],col);end();end()
def logo(name,x,y,size=40,colored=True):
    group(name+' logo',x,y);add(f'<g transform="scale({size/40})">')
    if name=='Spotify':
        circle(20,20,19,'#0b0b0b');path('M9 14Q20 9 32 15M11 21Q20 16 30 22M13 28Q21 23 28 28','#fff',2.4)
    elif name=='Netflix':
        rect(10,3,6,34,0,'#B20710' if colored else '#111');rect(25,3,6,34,0,'#B20710' if colored else '#111');path('M10 3h6l15 34h-6z','none',0,'#E50914' if colored else '#111')
    elif name=='iCloud':
        path('M8 32C-3 31-2 17 9 17c3-13 21-12 22 2 12 1 11 14 0 14Z','none',0,'#101010')
    elif name=='Adobe':
        path('M3 35V5h12L3 35Zm34 0V5H25l12 30ZM15 35l5-13 5 13z','none',0,'#111')
    elif name=='Notion':
        path('M4 7l5-4 27 2 1 31-28 2-5-3z','#111',2.3,'#fff');path('M9 7v26h25M12 12h5l11 16V12M13 12v17M12 29h7M26 12h5','#111',2.2)
    elif name=='ChatGPT':
        for a in range(0,360,60):
            add(f'<g transform="rotate({a} 20 20)">');path('M20 3c-8-2-13 4-11 11l-2 8 9 6 9-5V12l-9-5','#111',1.7);end()
    elif name=='YouTube':
        rect(2,7,36,27,8,'#111');path('M17 13l12 7-12 7z','none',0,'#fff')
    elif name=='Canva':
        path('M30 9C15-2 2 14 10 29c6 10 15 6 21-1','#111',4.5)
    elif name=='Google One':
        path('M14 13l10-8v30','#111',5)
    end();end()
def card(name,x,y,w,h,rad=22):
    group(name);rect(x,y,w,h,rad,'url(#card)','#ededed');end()
def status():
    group('System Status bar');text('9:41',36,16,14,600,'#050505')
    for i,h in enumerate([4,6,9,12]):rect(263+i*4,30-h,3,h,1,'#111')
    path('M284 21q7-5 14 0M287 24q4-3 8 0','#111',1.9);circle(291,27,1.5)
    rect(306,19,22,11,3,'none','#888');rect(308,21,17,7,1,'#111');rect(329,22,2,5,1,'#888');end()
def footer():rect(113,904,130,5,3,'#606060')
def nav():
    group('Navigation Subscriptions active');rect(0,844,356,55,0,'#fff');path('M0 844H356','#ededed',.7)
    for i,label in enumerate(['Home','Subscriptions','Insights','Profile']):
        x=42+i*83;c='#080808' if i==1 else '#c8c8c8'
        group(label,x-10,855)
        if i==0:path('M1 8l9-8 9 8v13h-6v-8H7v8H1z','none',0,c)
        elif i==1:
            rect(1,0,19,23,3,c);path('M5 6h11M5 11h11M5 16h8','#fff',1.5)
        elif i==2:
            rect(0,0,21,6,2,c);rect(0,10,21,13,2,c);path('M2 18l5-5 5 4 6-5','#fff',1.8)
        else:circle(10,6,5,c);path('M1 23v-3c0-11 18-11 18 0v3Z','none',0,c)
        end();text(label,x,883,9,400,'#111' if i==1 else '#888','middle')
    end()
def screen(name,x):
    group(name,x,54);rect(0,0,356,920,36,'url(#phone)');status()
def pill(s,x,y,w,selected=False):
    rect(x,y,w,34,18,'url(#black)' if selected else '#f7f7f7','#efefef' if not selected else None);text(s,x+w/2,y+8,12,400,'#fff' if selected else '#444','middle')
def badge(s,x,y,w,unused=False):
    rect(x,y,w,24,12,'#fff2d0' if unused else '#dff6e2');text(s,x+w/2,y+5,10 if unused else 11,500,'#493919' if unused else '#087923','middle')

add('<svg xmlns="http://www.w3.org/2000/svg" width="1148" height="1024" viewBox="0 0 1148 1024">')
add('''<defs><linearGradient id="phone" x1="0" y1="0" x2="1" y2="1"><stop stop-color="#fff"/><stop offset=".6" stop-color="#fdfdfd"/><stop offset="1" stop-color="#fafafa"/></linearGradient><linearGradient id="card" x1="0" y1="0" x2="1" y2="1"><stop stop-color="#fff"/><stop offset="1" stop-color="#fafafa"/></linearGradient><linearGradient id="black" x1="0" y1="0" x2="1" y2="1"><stop stop-color="#343434"/><stop offset=".55" stop-color="#111"/><stop offset="1" stop-color="#000"/></linearGradient><linearGradient id="glass" x1="0" y1="0" x2="1" y2="1"><stop stop-color="#fff"/><stop offset=".45" stop-color="#f0f0f0"/><stop offset=".75" stop-color="#fff"/><stop offset="1" stop-color="#eee"/></linearGradient></defs>''')
rect(0,0,1148,1024,0,'#f4f4f3')
screen('08 Subscriptions',34)
text('Subscriptions',22,63,27,700,'#080808');circle(268,80,19,'#fafafa');icon('search',258,70,20);circle(317,80,19,'url(#black)');icon('plus',307,70,20,'#fff')
for s,x,w,sel in [('All',22,54,True),('Active',85,75,False),('Trial',169,63,False),('Cancelled',241,96,False)]:pill(s,x,115,w,sel)
rows=[('Spotify Premium','Premium Plan','$10.99','Nov 4, 2026','Spotify'),('Netflix','Premium Plan','$15.49','Oct 18, 2026','Netflix'),('iCloud+','200 GB Plan','$2.99','Oct 12, 2026','iCloud'),('Adobe Creative Cloud','All Apps Plan','$22.99','Nov 6, 2026','Adobe'),('Notion','Plus Plan','$10.00','Oct 20, 2026','Notion'),('ChatGPT','Plus Plan','$20.00',None,'ChatGPT')]
for i,(title,plan,price,date,brand) in enumerate(rows):
    y=163+i*122;group(title+' subscription');card('Card',12,y,332,114);rect(25,y+14,54,54,17,'#fafafa');logo(brand,33,y+23,38)
    text(title,93,y+15,13,600);text(plan,93,y+37,12,400,'#777');text(price,93,y+60,17,600);text('/ month',93+(len(price)*9),y+63,12,400,'#777')
    if date:text('Next payment · '+date,93,y+85,12,400,'#777')
    if i==3:badge('Potentially unused',215,y+16,104,True)
    else:badge('Active',242,y+16,55)
    icon('chevron',309,y+45,16,'#aaa');end()
nav();footer();end()

screen('09 Spotify subscription details',406)
circle(35,73,18,'#fafafa');icon('back',25,63,20);circle(318,73,18,'#fafafa');text('···',318,57,23,600,'#111','middle')
rect(20,110,104,106,29,'url(#glass)','#ddd');rect(25,115,94,96,24,'none','#fff');logo('Spotify',38,128,68)
text('Spotify Premium',137,115,21,700);text('Premium Plan',137,146,14,400,'#777');badge('Active',137,172,53)
text('$10.99',137,203,29,700);text('/ month',235,210,18,400,'#777')
for x,label,value,ico in [(17,'Next payment','November 4, 2026','calendar'),(190,'Payment method','Visa •••• 4242','card')]:
    card(label,x,250,150 if x==190 else 164,64,18);circle(x+26,282,18,'#f7f7f7');icon(ico,x+16,272,20);text(label,x+54,262,11,400,'#777');text(value,x+54,281,12,500)
rect(18,338,320,35,18,'#f5f5f5','#ececec');pill('Overview',18,338,107,True);text('Payments',183,348,12,400,'#666','middle');text('Insights',287,348,12,400,'#666','middle')
card('Monthly spending chart',16,386,324,185,23);text('Monthly spending',33,404,14,600);rect(248,402,73,23,12,'#f4f4f4');text('$10.99 avg',284,407,11,400,'#666','middle')
for val,y in [('$20',445),('$10',484),('$0',524)]:text(val,33,y,10,400,'#888');path(f'M65 {y+7}H312','#eee',.7)
points=[(73,498),(121,501),(168,493),(215,484),(263,488),(310,479)]
path('M73 498C92 486 102 506 121 501S150 494 168 493S197 482 215 484S245 491 263 488S292 478 310 479','#080808',2)
for (x,y),mon in zip(points,['May','Jun','Jul','Aug','Sep','Oct']):circle(x,y,4,'#111');text(mon,x,540,10,400,'#888','middle')
for x,label,value,ico in [(16,'Yearly cost','$131.88','db'),(184,'Last opened','18 days ago','clock')]:
    card(label,x,584,156,76,22);circle(x+26,620,19,'#f7f7f7');icon(ico,x+16,610,20);text(label,x+55,600,11,400,'#777');text(value,x+55,620,17,600)
text('Payment history',18,687,18,600);text('See all',338,691,14,400,'#666','end')
for i,date in enumerate(['Oct 4, 2026','Sep 4, 2026','Aug 4, 2026']):
    y=721+i*51;card(date,16,y,324,49,19);circle(40,y+24,14,'#f8f8f8');icon('check',31,y+15,18);text(date,69,y+15,13,400,'#555');text('$10.99',300,y+15,13,500,'#111','end');icon('chevron',312,y+16,17,'#aaa')
footer();end()

screen('10 Add subscription',778)
circle(35,73,18,'#fafafa');icon('back',25,63,20);text('Add subscription',178,61,16,600,'#111','middle')
rect(18,105,320,47,25,'#f7f7f7');icon('search',37,119,21);text('Search services',72,121,12,400,'#777')
text('Popular services',18,177,16,600);text('See all',338,180,13,400,'#666','end')
for i,name in enumerate(['Netflix','Spotify','ChatGPT','YouTube','iCloud','Adobe','Canva','Google One']):
    x=24+(i%4)*83;y=211+(i//4)*97;rect(x,y,61,61,18,'url(#glass)');logo(name,x+13,y+12,36,False);text(name,x+30.5,y+68,11,400,'#666','middle')
text('Enter details manually',18,413,16,600)
card('Service field',18,441,320,45,17);circle(47,463,14,'#f7f7f7');icon('service',39,455,16);text('Select a service',86,456,12,400,'#999');icon('chevron',313,455,17,'#aaa')
card('Plan field',18,488,320,42,17);text('Plan',34,501,12,400,'#555');text('E.g. Premium Plan',86,501,12,400,'#999')
card('Category field',18,532,320,47,17);text('Category',34,548,12,400,'#555');text('Select category',114,548,12,400,'#999');icon('chevron',313,547,17,'#aaa')
card('Price field',18,582,173,65,19);text('Price',34,605,12,400,'#555');text('$0.00',86,605,13,400,'#999')
card('Currency field',198,582,140,65,19);text('Currency',214,593,12,400,'#555');text('USD',214,614,14,500);icon('chevron',312,606,17,'#aaa')
card('Billing cycle field',18,650,320,46,17);text('Billing cycle',34,665,12,400,'#555');text('Monthly',126,665,13,500);icon('chevron',313,664,17,'#aaa')
card('Next payment date field',18,699,320,47,17);icon('calendar',37,713,19);text('Next payment date',71,715,11,400,'#555');rect(198,706,130,33,10,'#fcfcfc');icon('calendar',211,717,13,'#bbb');text('Select date',237,715,11,400,'#999')
card('Payment method field',18,749,320,47,17);icon('card',37,763,19);text('Select payment method',86,765,12,400,'#999');icon('chevron',313,763,17,'#aaa')
rect(18,820,320,48,25,'url(#black)');text('Add subscription',178,835,15,500,'#fff','middle');footer();end()
add('</svg>')
svg=''.join(parts)
(OUT/'subtrack-subscriptions.svg').write_text(svg,encoding='utf-8')
print(f'Saved three editable screens: {len(svg)} bytes, {svg.count("<text")} text layers')

from pathlib import Path
import base64

base=Path(__file__).with_name('build-subscription-screens.py').read_text(encoding='utf-8')
exec(base[:base.index("add('<svg")])
icons.update({
 'mail':'M2 5h20v15H2zM2 6l10 8L22 6',
 'trash':'M3 6h18M9 6V3h6v3M6 6l1 16h10l1-16M10 10v8M14 10v8',
 'music':'M8 18V5l12-2v13M8 8l12-2M8 18c0 4-7 4-7 0s7-4 7 0M20 16c0 4-7 4-7 0s7-4 7 0',
 'notes':'M4 3h16v18H4zM8 7h8M8 11h8M8 15h5',
 'spark':'M12 3l2.5 6.5L21 12l-6.5 2.5L12 21l-2.5-6.5L3 12l6.5-2.5zM20 2v4M18 4h4',
 'down':'M12 2v19M3 12l9 9 9-9',
 'bulb':'M8 17c0-4-4-4-4-9a8 8 0 0 1 16 0c0 5-4 5-4 9zM8 20h8M10 23h4',
 'bars':'M3 15h3v7H3zM10 9h3v13h-3zM17 3h3v19h-3z',
 'megaphone':'M3 8l15-5v17L3 15zM3 8v7M6 16l2 6h4l-2-5M21 7v9',
 'timer':'M12 22a9 9 0 1 1 0-18 9 9 0 0 1 0 18M9 1h6M12 1v7',
 'cancel':'M12 22a10 10 0 1 1 0-20 10 10 0 0 1 0 20M5 5l14 14',
 'spinner':'M21 12a9 9 0 1 1-3-7M18 2v5h5',
 'arrow':'M3 12h18M15 6l6 6-6 6',
})
def bitmap(name,x,y,w,h,filename):
    raw=Path(filename).read_bytes();data=base64.b64encode(raw).decode()
    add(f'<image id="{name}" x="{x}" y="{y}" width="{w}" height="{h}" preserveAspectRatio="xMidYMid meet" href="data:image/png;base64,{data}"/>')
def toggle(name,x,y,on=True):
    group(name);rect(x,y,42,26,14,'#050505' if on else '#d1d1d1');circle(x+(30 if on else 12),y+13,10,'#fff');end()
def nav(active_tab):
    group('Navigation '+active_tab+' active');rect(0,844,356,55,0,'#fff');path('M0 844H356','#eee',.7)
    for i,label in enumerate(['Home','Subscriptions','Insights','Profile']):
        x=42+i*83;c='#080808' if label==active_tab else '#c8c8c8';group(label,x-10,855)
        if i==0:path('M1 8l9-8 9 8v13h-6v-8H7v8H1z','none',0,c)
        elif i==1:rect(1,0,19,23,3,c);path('M5 6h11M5 11h11M5 16h8','#fff',1.5)
        elif i==2:rect(0,0,21,6,2,c);rect(0,10,21,13,2,c);path('M2 18l5-5 5 4 6-5','#fff',1.8)
        else:circle(10,6,5,c);path('M1 23v-3c0-11 18-11 18 0v3Z','none',0,c)
        end();text(label,x,883,9,400,'#111' if label==active_tab else '#888','middle')
    end()
def back():circle(35,72,18,'#fafafa');icon('back',25,62,20)
def checked(x,y,on=True):
    if on:rect(x,y,20,20,6,'#0a0a0a');path(f'M{x+5} {y+10}l3 3 7-7','#fff',1.5)
    else:add(f'<circle cx="{x+10}" cy="{y+10}" r="10" fill="#fff" stroke="#ddd" stroke-width="1.5"/>')

add('<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1536" height="1024" viewBox="0 0 1536 1024">')
defs=base[base.index("add('''<defs>")+7:base.index("</defs>''')")+7]
add(defs);rect(0,0,1536,1024,0,'#f4f4f3')
screen('11 Gmail scanning',34);back();rect(252,56,83,38,20,'#fff','#e6e6e6');text('Cancel',293.5,67,13,400,'#111','middle')
bitmap('Image Gmail scan hero',16,96,324,355,r'D:/my_projects/susbtrack/assets/onboarding/gmail-scan-hero.png')
path('M40 478V604','#d8d8d8',1)
for i,(label,detail) in enumerate([('Searching billing emails','248 emails scanned'),('Finding recurring payments','12 potential subscriptions'),('Checking renewal patterns',None),('Almost done...',None)]):
    y=466+i*40;circle(40,y+12,13,'#efefef')
    if i<2:path(f'M35 {y+12}l4 4 6-7','#111',1.5)
    elif i==2:circle(40,y+12,7,'#080808');icon('spinner',315,y+3,17,'#888')
    else:circle(40,y+12,7,'#d8d8d8')
    text(label,65,y+3,12,400,'#999' if i==3 else '#111')
    if detail:text(detail,331,y+4,10,400,'#999','end')
card('Found subscriptions so far',18,633,320,202,21);text('Found so far',35,649,13,400);text('8',320,648,15,600,'#111','end')
for i,(name,brand) in enumerate([('Spotify','Spotify'),('Netflix','Netflix'),('iCloud+','iCloud'),('ChatGPT','ChatGPT')]):
    y=680+i*38;logo(brand,39,y+2,22);text(name,82,y+5,12,400);text('Found',281,y+6,10,400,'#888','end');circle(309,y+13,12,'#eee');path(f'M305 {y+13}l3 3 6-6','#111',1.3)
    if i<3:path(f'M36 {y+36}H322','#eee',.6)
nav('Home');footer();end()

screen('12 Review found subscriptions',406);back();rect(266,52,74,38,20,'#fff','#e6e6e6');text('Skip',303,63,13,400,'#111','middle')
circle(48,126,28,'#f7f7f7');icon('mail',37,115,22);text('We found 11',91,101,20,700);text('recurring subscriptions',91,123,20,700);text('From your Gmail. Review and confirm them.',91,151,12,400,'#888')
card('Monthly total',18,186,320,114,23);text('Monthly total',36,203,13,400,'#555');text('$73.42',36,224,37,700);text('/ month',159,244,16,400,'#777');text('$881.04 / year',36,270,13,400,'#777')
for i,h in enumerate([26,42,60,80]):rect(226+i*27,284-h,15,h,8,'url(#glass)')
circle(315,208,3.5)
for label,x,w,on in [('All (11)',22,95,True),('New (3)',131,95,False),('Existing (8)',241,95,False)]:pill(label,x,318,w,on)
rows=[('Spotify','Premium Plan','$10.99','Spotify',True),('Netflix','Premium Plan','$15.49','Netflix',True),('iCloud+','200 GB Plan','$2.99','iCloud',True),('ChatGPT Plus','Plus Plan','$20.00','ChatGPT',True),('Adobe Creative Cloud','All Apps Plan','$22.99','Adobe',False),('YouTube Premium','Individual Plan','$13.99','YouTube',False)]
for i,(label,plan,amount,brand,on) in enumerate(rows):
    y=360+i*73;card(label,18,y,320,66,20);rect(30,y+7,53,52,16,'url(#glass)');logo(brand,38,y+15,37);text(label,103,y+8,13,600);text(plan,103,y+27,11,400,'#888');text(amount,103,y+43,13,600);text('/ month',103+len(amount)*7.5,y+45,11,400,'#888');checked(298,y+22,on)
rect(22,794,312,45,23,'url(#black)');text('Add 8 subscriptions',170,808,14,500,'#fff','middle');icon('arrow',242,808,19,'#fff')
rect(18,850,320,48,25,'#fff','#e7e7e7');text('Manually add instead',178,865,13,500,'#111','middle');footer();end()

screen('13 Edit Spotify subscription',778);back();circle(318,72,19,'#fafafa');icon('trash',308,62,20,'#f22')
rect(18,103,68,73,22,'url(#glass)','#eee');logo('Spotify',29,116,46);text('Spotify Premium',102,110,18,700);text('Premium Plan',102,134,12,400,'#888');badge('Active',102,157,51)
card('Subscription fields',18,193,320,434,22)
fields=[('Service','Spotify','Spotify'),('Plan','Premium Plan',None),('Category','Music','music'),('Price','$10.99',None),('Currency','USD',None),('Billing cycle','Monthly',None),('Next payment date','Nov 4, 2026','calendar'),('Payment method','Visa •••• 4242','card'),('Notes','Add a note...','notes')]
for i,(label,value,ico) in enumerate(fields):
    y=193+i*48;group(label+' field');text(label,35,y+17,13,400);text(value,305 if i in [0,1,2] else 320,y+17,13,400,'#aaa' if i==8 else '#666','end')
    if ico:
        if ico=='Spotify':logo('Spotify',198,y+15,24)
        else:icon(ico,220 if i==2 else 205,y+16,18)
    if i in [0,1,2]:icon('chevron',311,y+16,16,'#aaa')
    if i<8:path(f'M35 {y+48}H320','#eee',.65)
    end()
card('Remind me before payment',18,649,320,65,22);icon('timer',36,670,23);text('Remind me before payment',76,664,13,400);text('Get a notification 3 days before',76,685,11,400,'#888');toggle('Reminder enabled',284,668)
card('Mark as cancelled',18,714,320,60,22);icon('cancel',36,733,21,'#f22');text('Mark as cancelled',76,727,13,400,'#f22');text('Keep it in your history',76,749,11,400,'#888');icon('chevron',306,735,19,'#aaa')
rect(22,795,312,47,25,'url(#black)');text('Save changes',178,810,14,500,'#fff','middle');nav('Insights');footer();end()

screen('14 Notifications settings',1150);back();text('Notifications',178,61,16,700,'#111','middle')
rect(18,104,320,105,22,'#f6f6f6');bitmap('Image glass bell',32,112,84,84,r'D:/my_projects/susbtrack/assets/onboarding/notification-bell.png');text('Stay informed',129,130,14,600);text('Get notified about upcoming payments,',129,153,10.5,400,'#888');text('price changes, and insights.',129,169,10.5,400,'#888')
text('Payment reminders',21,230,15,600);card('Payment reminders settings',18,254,320,108,21)
icon('calendar',36,272,23);text('Upcoming payments',82,266,13,400);text('Get notified before a payment is due.',82,287,11,400,'#888');toggle('Upcoming payments enabled',286,269)
path('M34 311H322','#eee',.65);icon('clock',36,325,22);text('Reminder timing',82,327,13,400);text('3 days before',307,327,13,400,'#666','end');icon('chevron',314,328,16,'#aaa')
text('Price changes',21,386,15,600);card('Price change settings',18,410,320,145,21)
for i,(title,ico,desc) in enumerate([('Price increase alerts','spark','price goes up.'),('Price decrease alerts','down','price goes down.')]):
    y=422+i*72;icon(ico,36,y+9,23);text(title,82,y,13,400);text('Get notified when a subscription',82,y+21,11,400,'#888');text(desc,82,y+36,11,400,'#888');toggle(title+' enabled',286,y+7)
path('M34 482H322','#eee',.65)
text('Insights & recommendations',21,578,15,600);card('Insights settings',18,602,320,121,21)
for i,(title,ico,desc) in enumerate([('Savings opportunities','bulb','Get notified about potential savings.'),('Unused subscriptions','bars','Get notified about low activity.')]):
    y=615+i*61;icon(ico,36,y+8,23);text(title,82,y,13,400);text(desc,82,y+21,11,400,'#888');toggle(title+' enabled',286,y+7)
path('M34 662H322','#eee',.65)
text('General',21,747,15,600);card('General notifications',18,773,320,59,20);icon('megaphone',36,790,23);text('Product updates',82,785,13,400);text('New features and important updates.',82,806,11,400,'#888');toggle('Product updates disabled',286,789,False)
nav('Profile');footer();end();add('</svg>')
out=OUT/'subtrack-detail-screens.svg';out.write_text(''.join(parts),encoding='utf-8');print(f'Saved {out}: {out.stat().st_size} bytes; {sum(p.startswith("<text") for p in parts)} editable text layers')

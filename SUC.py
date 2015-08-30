from bottle import *
from bs4 import BeautifulSoup
from bs4 import SoupStrainer
import urllib2

@get('/login') 
def login():
    return '''
        <!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
    <link rel="stylesheet" type="text/css" href="stylesheets/stylesheet.css" media="screen">
    <link rel="stylesheet" type="text/css" href="stylesheets/github-dark.css" media="screen">
    <link rel="stylesheet" type="text/css" href="stylesheets/print.css" media="print">
    <title>Sukeesh</title>
  </head>

  <body>

    <header>
      <div class="container">
        <h1>Sukeesh</h1>
        <h2>Programmer. Developer.</h2>

        <section id="downloads">
          <a href="https://github.com/vsukeeshbabu" class="btn btn-github"><span class="icon"></span>View on GitHub</a> 
          <a href="https://sukeesh.wordpress.com" class="btn btn-wordpress"><span class="icon"></span>Blog</a>
          <a href="about.html" class="btn btn-about"><span class="icon"></span>About</a>
          <a href="projects.html" class="btn btn-about"><span class="icon"></span>myProjects</a>
        </section>
      </div>
    </header>

    <div class="container">
      <section id="main_content">
        <h3><p id="indexMain" align="center">
<a id="welcome-to-github-pages" class="anchor" href="#welcome-to-github-pages" aria-hidden="true"><span class="octicon octicon-link"></span></a>SUC</p></h3>
      <form action="/login" method="post">
            User1 : <input name="user1" type="text" /><br>
            User2 : <input name="user2" type="text" /><br>
            <input value="Check" type="submit" />
        </form>
      </section>
    </div>

    
  </body>
</html>

    '''

@post('/login') 
def do_login():
    user1 = request.forms.get('user1')
    user2 = request.forms.get('user2')
    return do_it(user1, user2)

def do_it(user1, user2):
    url="http://www.spoj.com/users/"
    x1=user1
    x2=user2
    url1 = url + x1
    url2 = url + x2
    page1=urllib2.urlopen(url1)
    soup1=BeautifulSoup(page1.read())
    page2=urllib2.urlopen(url2)
    soup2=BeautifulSoup(page2.read())
    problemss1 = soup1.body.table.find_all('a')
    problemss2 = soup2.body.table.find_all('a')
    no_of_problems_solved_by_user1 = 0
    no_of_problems_solved_by_user2 = 0
    problems1 = []
    problems2 = []
    for i in problemss1:
        problems1.append(i.string)
        no_of_problems_solved_by_user1=no_of_problems_solved_by_user1+1
    for i in problemss2:
        problems2.append(i.string)
        no_of_problems_solved_by_user2=no_of_problems_solved_by_user2+1
    problems_solved_by_user2_not_by_user1 = []
    problems_solved_by_user1_not_by_user2 = []
    for i in problems1:
        c=0
        for j in problems2:
            if i==j:
                c=1
        if c==0:
            problems_solved_by_user2_not_by_user1.append(i)

    for i in problems2:
        c=0
        for j in problems1:
            if i==j:
                c=1
        if c==0:
            problems_solved_by_user1_not_by_user2.append(i)
    return "Problems Solved by " + user1 + str(no_of_problems_solved_by_user1)  + " and " + "Problems Solved by " + user2 + str(no_of_problems_solved_by_user2)

run(host="localhost", port=8080, debug=True)
import pygame as pg
from spritesheet_function import Spritesheet

pg.init()
pg.mixer.init()

# Global constants
Black = (0, 0, 0)
White = (255, 255, 255)
Blue = (0, 0, 255)

# Screen dimensions
screenWidth = 500
screenHeight = 500
win = pg.display.set_mode((screenWidth,screenHeight))

pg.display.set_caption("Moving popuri")

x = 20 # Your character
y = 20 # Your character
width = 25
height = 25
velocity = 5
clock = pg.time.Clock()



popuri_sprites = Spritesheet("Popuri.png")

# Character sprites
popuri_idle = [popuri_sprites.get_image_name("walkdown_2.png")]
popuri_left = [popuri_sprite.get_image_name("walkleft_1.png"), popuri_sprite.get_image_name("walkleft_2.png"), popuri_sprite.get_image_name("walkleft_3.png")]
popuri_right = [popuri_sprite.get_image_name("walkright_1.png"), popuri_sprite.get_image_name("walkright_2.png"), popuri_sprite.get_image_name("walkright_3.png")]

# Background image
bg = pg.image.load("bg.jpg").convert()
walkCount = 0

def redrawGameWindow():
    global walkCount
    win.blit(bg,(0,0))

    if walkCount + 1 >= 27:
        walkCount = 0
    if left:
        win.blit(walkLeft[walkCount//3], (x,y))
        walkCount += 1
    elif right:
        win.blit(walkRight[walkCount//3], (x,y))
        walkCount += 1
    else:
        win.blit[character, (x,y)]

    pg.display.update()

# Main loop
run = True

while run:
    clock.tick(9) # setting FPS to 27, depends on the number of sprites available
    # event in pg means whether user has clicked or bumped into something
    for event in pg.event.get():
        if event.type == pg.QUIT:
            run = False

    keys = pg.key.get_pressed()

    if keys[pg.K_LEFT] and x > velocity:
        x -= velocity
    elif keys[pg.K_RIGHT] and x < (screenWidth - width - velocity):
        x += velocity
    elif keys[pg.K_UP] and y > velocity:
        y -= velocity
    elif keys[pg.K_DOWN] and y < (screenWidth - height - velocity):
        y += velocity

    else:
        right = False
        left = False
        walkCount = 0

    redrawGameWindow()


pg.quit()

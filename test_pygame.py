"""
Pygame skeleton
"""
import pygame as pg
import random

swidth = 500
sheight = 500
fps = 30

# Initializing pygame and create window
pg.init()
pg.mixer.init()
screen = pg.display.set_mode((swidth, sheight))
pg.display.set_caption("Test game")
clock = pg.time.Clock()

# Background image
bg = pg.image.load("bg.jpg").convert()

# Main game loop
run = True
while run:
    # keep running at certain FPS
    clock.tick(fps)
    # Process input (events)
    for event in pg.event.get():
        # Check for closing the window
        if event.type == pg.QUIT:
            run = False

    # update

    # Draw / render
    screen.blit(bg, (0,0))
    pg.display.update()

pg.quit()

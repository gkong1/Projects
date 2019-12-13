"""
Pygame skeleton
"""
import pygame
import random
import os

swidth = 800
sheight = 450
fps = 30
BLACK = (0,0,0)
white = (255,255,255)

# set up assets folder
game_folder = os.path.dirname(__file__)
img_folder = os.path.join(game_folder,"img")

class Player(pygame.sprite.Sprite):
    # sprite for the player
    def __init__(self):
        pygame.sprite.Sprite.__init__(self)
        # create plain rectangle for sprite image
        self.image = player_img
        self.image.set_colorkey(white)
        # Find rectangle that encloses the image
        self.rect = self.image.get_rect()
        # player at center at start
        self.rect.centerx = swidth / 2
        self.rect.bottom = sheight - 10
        self.speedx = 0
        self.speedy = 0 # velocity moving vertically

    def update(self):
        self.speedx = 0
        self.speedy = 0
        keystate = pygame.key.get_pressed()
        if keystate[pygame.K_LEFT]:
            self.speedx = -8
        if keystate[pygame.K_RIGHT]:
            self.speedx = 8
        if keystate[pygame.K_UP]:
            self.speedy = -8
        if keystate[pygame.K_DOWN]:
            self.speedy = 8
        self.rect.x += self.speedx
        self.rect.y += self.speedy
        if self.rect.right > swidth:
            self.rect.right = swidth
        if self.rect.left < 0:
            self.rect.left = 0

class Mob(pygame.sprite.Sprite):
    def __init__(self):
        pygame.sprite.Sprite.__init__(self)
        self.image = pygame.image.load(os.path.join(img_folder,"L1E.png")).convert_alpha()
        self.image.set_colorkey(white)
        self.rect = self.image.get_rect()
        self.rect.x = swidth*0.75
        self.rect.bottom = sheight - 10
        self.speedx = 4

    def update(self):
        self.rect.x += self.speedx
        if self.rect.right <= (swidth/2 + 50):
            self.speedx = 4

        if self.rect.left >= (swidth - 50):
            self.speedx = -4


# Initializing pygame and create window
pygame.init()
pygame.mixer.init()
screen = pygame.display.set_mode((swidth, sheight))
pygame.display.set_caption("Test game")
clock = pygame.time.Clock()

# Set up game image
bg = pygame.image.load("img/bg.jpg").convert()
bg_rect = bg.get_rect()
player_img = pygame.image.load("img/standing.png").convert_alpha()
mob_image_right = [pygame.image.load("img/R1E.png"), \
                   pygame.image.load("img/R2E.png"), \
                   pygame.image.load("img/R3E.png"), \
                   pygame.image.load("img/R4E.png"), \
                   pygame.image.load("img/R5E.png"), \
                   pygame.image.load("img/R6E.png")]

# Sprite groups
all_sprites = pygame.sprite.Group()
mobs = pygame.sprite.Group()
player = Player()
all_sprites.add(player)
for i in range(1):
    m = Mob()
    all_sprites.add(m)
    mobs.add(m)

# Main game loop
run = True
while run:
    # keep running at certain FPS
    clock.tick(fps)
    # Process input (events)
    for event in pygame.event.get():
        # Check for closing the window
        if event.type == pygame.QUIT:
            run = False

    # update
    all_sprites.update()

    # check for collision
    hits = pygame.sprite.spritecollide(player,mobs, False)


    # Draw / render
    screen.blit(bg, bg_rect
    all_sprites.draw(screen)
    pygame.display.flip()

pygame.quit()

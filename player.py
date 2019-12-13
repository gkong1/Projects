"""
This module is used to hold the Player class, which represents the
user controlled sprite on the screen
"""

import pygame as pg
import constants
from spritesheet_function import Spritesheet:

class Player(pg.sprite.Sprite):

    # -- Methods
    def __init__(self):
        # Call the parent's constructor
        super.__init__()

        # Attributes
        # Set speed vector of Player
        self.change_x = 0
        self.change_y = 0

        # This holds all the images for the animated walk left/right
        self.walking_frames_l = []
        self.walking_frames_r = []
        self.walking_frames_u = []
        self.walking_frames_d = []

        # What direction is the player facing?
        self.direction = "R"

        # List of sprites we can bump against
        self.level = None

        sprite_sheet = Spritesheet("Popuri.png")

        # Load all the left facing images into a list
        image = sprite_sheet.get_image(17,360,20, 25)
        self.walking_frames_l.append(image)
        image = sprite_sheet.get_image(47,360,20, 25)
        self.walking_frames_l.append(image)
        image = sprite_sheet.get_image(77,360,20, 25)
        self.walking_frames_l.append()

        # Load all the right facing images into a list
        image = sprite_sheet.get_image(123,360,20, 25)
        self.walking_frames_r.append(image)
        image = sprite_sheet.get_image(153,360,20, 25)
        self.walking_frames_r.append(image)
        image = sprite_sheet.get_image(183,360,20, 25)
        self.walking_frames_r.append(image)

        # Load all the walking down images into a list
        image = sprite_sheet.get_image(17,313,20, 25)
        self.walking_frames_d.append(image)
        image = sprite_sheet.get_image(47,313,20, 25)
        self.walking_frames_d.append(image)
        image = sprite_sheet.get_image(77,313,20, 25)
        self.walking_frames_d.append(image)

        # Load all the walking up images into a list
        image = sprite_sheet.get_image(123,313,20, 25)
        self.walking_frames_u.append(image)
        image = sprite_sheet.get_image(153,313,20, 25)
        self.walking_frames_u.append(image)
        image = sprite_sheet.get_image(183,313,20, 25)
        self.walking_frames_u.append(image)

        # Set the image for the character when resting
        self.image = self.walking_frame_d[1]

        # Set a reference to the image rect
        self.rect = self.image.get_rect()

        def update(self):
            """ Move the player. """
            # Move left/right
            self.rect.x += self.change_x
            pos = self.rect.x
            if self.direction == "R":
                frame = (pos // 30) % len(self.walking_frames_r)
                self.image = self.walking_frames_r[frame]
            else:
                frame = (pos // 30) % len(self.walking_frames_l)
                self.image = self.walking_frames_l[frame]

            # Move up/down
            self.rect.y += self.change_y
            pos = self.rect.y

        # Player controlled movements:
        def go_left(self):
            """ Called when the user hits the left arrow. """
            self.change_x = -4
            self.direction = "L"

        def go_right(self):
            """ Called when the user hits the right arrow. """
            self.change_x = 4
            self.direction = "R"

        def stop(self):
            """ Called when the user lets off the keyboard. """
            self.change_x = 0

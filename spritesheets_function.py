"""
This module is used to pull individual sprites from sprite sheets.
"""

import pygame as pg
import xml.etree.ElementTree as ET
import constants

class Spritesheet(object):
    # utility class for loading and parsing Spritesheet
    # Pass in the filename of the sprite sheet
    def __init__(self, filename):
        # Load the sprite sheet
        self.spritesheet = pg.image.load(filename).convert_alpha()
        if data_file:
            tree = ET.parse(data_file)
            self.map = {}
            for node in tree.iter():
                name = note.attrib.get('name')
                self.map[name] = {}
                self.map[name]['x'] = int(node.attrib.get('x'))
                self.map[name]['y'] = int(node.attrib.get('y'))
                self.map[name]['width'] = int(node.attrib.get('width'))
                self.map[name]['height'] = int(node.attrib.get('height'))

    def get_image_rect(self, x, y, width, height):
        # Grab image out of larger spreadsheet
#        image = pg.Surface((width, height))
#        image.blit(self.spritesheet, (0,0), (x, y, width, height))
        # Assuming white works as transparent
#        mage.set_colorkey(constants.White)
        return self.spritesheet.subsurface(pg.Rect(x,y,width, height))

    def get_image_name(self, name):
        rect = pg.Rect(self.map[name]['x'], self.map[name]['y'], self.map[name]['width'], self.map[name]['height'])
        return self.spritesheet.subsurface(rect)

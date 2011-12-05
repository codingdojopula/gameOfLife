package hr.codingdojo.puls.gol.mstipanov.ui.impl;

import hr.codingdojo.puls.gol.mstipanov.Cell;
import hr.codingdojo.puls.gol.mstipanov.GameOfLifeController;
import hr.codingdojo.puls.gol.mstipanov.ui.GameOfLifePresenter;

import javax.swing.*;
import javax.swing.border.LineBorder;
import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.util.HashMap;

/**
 * @author mstipanov
 * @since 04.12.11. 18:37
 */
public class GameOfLifePanel extends JPanel implements GameOfLifePresenter {
    private HashMap<Postiton, JComponent> fields = new HashMap<Postiton, JComponent>();
    private Color deadColor;
    private Color aliveColor = Color.BLUE;

    private GameOfLifeController gameOfLifeController;

    public GameOfLifePanel(GameOfLifeController gameOfLifeController) {
        this.gameOfLifeController = gameOfLifeController;
        setLayout(new GridBagLayout());
        for (int y = 0; y < 100; y++) {
            for (int x = 0; x < 100; x++) {
                JButton label = new JButton("");
                label.setBorder(new LineBorder(Color.DARK_GRAY, 1));
                if (null == deadColor)
                    deadColor = label.getBackground();
                add(label, new GridBagConstraints(x, y, 1, 1, 1., 1., GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(0, 0, 0, 0), 0, 0));
                fields.put(new Postiton(x, y), label);
            }
        }
    }

    public void draw(Cell[][] cells) {
        for (int y = 0; y < cells.length; y++) {
            for (int x = 0; x < cells[y].length; x++) {
                Cell cell = cells[x][y];
                fields.get(new Postiton(x, y)).setBackground(cell.isAlive() ? aliveColor : deadColor);
            }
        }
    }

    public void show() {
        JFrame frame = new JFrame("Game of Life: Swing");
        frame.setSize(800, 600);
        frame.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });
        frame.setLayout(new GridBagLayout());
        frame.add(this, new GridBagConstraints(0, 0, 1, 1, 100., 100., GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(0, 0, 0, 0), 0, 0));
        frame.add(new GameOfLifeButtonsPanel(gameOfLifeController), new GridBagConstraints(0, 1, 1, 1, 100., 3., GridBagConstraints.BASELINE, GridBagConstraints.BOTH, new Insets(0, 0, 0, 0), 0, 0));
        frame.setVisible(true);
    }

    private class Postiton {
        private final int x;
        private final int y;

        private Postiton(int x, int y) {
            this.x = x;
            this.y = y;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;

            Postiton postiton = (Postiton) o;

            if (x != postiton.x) return false;
            if (y != postiton.y) return false;

            return true;
        }

        @Override
        public int hashCode() {
            int result = x;
            result = 31 * result + y;
            return result;
        }
    }
}

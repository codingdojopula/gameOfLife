package hr.codingdojo.puls.gol.mstipanov.ui.impl;

import hr.codingdojo.puls.gol.mstipanov.GameOfLifeController;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * @author mstipanov
 * @since 04.12.11. 18:37
 */
public class GameOfLifeButtonsPanel extends JPanel {

    private JButton exitButton;
    private JButton nextButton;
    private JButton clearButton;
    private GameOfLifeController gameOfLifeController;

    public GameOfLifeButtonsPanel(GameOfLifeController gameOfLifeController) {
        this.gameOfLifeController = gameOfLifeController;
        setLayout(new GridBagLayout());
        add(new JPanel(), new GridBagConstraints(0, 0, 1, 100, 1., 1., GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(0, 0, 0, 0), 0, 0));
        add(getClearButton(), new GridBagConstraints(1, 0, 1, 1, 1., 1., GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(0, 0, 0, 0), 0, 0));
        add(getNextButton(), new GridBagConstraints(2, 0, 1, 1, 1., 1., GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(0, 0, 0, 0), 0, 0));
        add(getExitButton(), new GridBagConstraints(3, 0, 1, 1, 1., 1., GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(0, 0, 0, 0), 0, 0));
    }

    private JButton getExitButton() {
        if (null != exitButton)
            return exitButton;

        exitButton = new JButton("Exit");
        exitButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                System.exit(0);
            }
        });

        return exitButton;
    }

    private JButton getNextButton() {
        if (null != nextButton)
            return nextButton;

        nextButton = new JButton("Next");
        nextButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                gameOfLifeController.next();
            }
        });

        return nextButton;
    }

    private JButton getClearButton() {
        if (null != clearButton)
            return clearButton;

        clearButton = new JButton("Clear");
        clearButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                gameOfLifeController.clear();
            }
        });

        return clearButton;
    }
}

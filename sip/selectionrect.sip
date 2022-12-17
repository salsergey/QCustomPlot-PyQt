/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */

class QCPSelectionRect : public QCPLayerable
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  QCPSelectionRect(QCustomPlot *parentPlot /TransferThis/);
  virtual ~QCPSelectionRect();

  // getters:
  QRect rect() const;
  QCPRange range(const QCPAxis *axis) const;
  QPen pen() const;
  QBrush brush() const;
  bool isActive() const;

  // setters:
  void setPen(const QPen &pen);
  void setBrush(const QBrush &brush);

  // non-property methods:
  Q_SLOT void cancel();

signals:
  void started(QMouseEvent *event);
  void changed(const QRect &rect, QMouseEvent *event);
  void canceled(const QRect &rect, QInputEvent *event);
  void accepted(const QRect &rect, QMouseEvent *event);

protected:
  // introduced virtual methods:
  virtual void startSelection(QMouseEvent *event);
  virtual void moveSelection(QMouseEvent *event);
  virtual void endSelection(QMouseEvent *event);
  virtual void keyPressEvent(QKeyEvent *event);

  // reimplemented virtual methods
  virtual void applyDefaultAntialiasingHint(QCPPainter *painter) const;
  virtual void draw(QCPPainter *painter);
};
